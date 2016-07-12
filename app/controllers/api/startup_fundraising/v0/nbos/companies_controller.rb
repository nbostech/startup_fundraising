class Api::StartupFundraising::V0::Nbos::CompaniesController < Api::StartupFundraising::V0::StartupBaseController

	before_action :get_member, only: [:create, :update_profile, :update, :delete]

	def index
		companyType = params[:company_type]
		company_categories = ['deal_bank', 'funding_progress', 'portfolio']
		if companyType.present? && company_categories.include?(companyType)
			if companyType == "portfolio"  
				@companies_list = Com::Nbos::StartupFundraising::Company.active_companies.where(is_funded: true).page(params[:page])
			elsif companyType == "deal_bank" && @member.present?
				@companies_list = Com::Nbos::StartupFundraising::Company.active_companies.page(params[:page])
			elsif companyType == "funding_progress" && @member.present?
				company_ids = Com::Nbos::StartupFundraising::FundingRound.all.collect {|i| i.company_id}
				@companies_list = Com::Nbos::StartupFundraising::Company.where(id: company_ids).page(params[:page])
			end
			paginate json: @companies_list, per_page: params[:per_page]
		elsif @token_details.present? && @member.present?
			member = Com::Nbos::User.where(uuid: @token_details.uuid).first
			@companies = member.companies
			paginate json: @companies, per_page: params[:per_page]
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400 
		end
	end

	def create
		if params[:startup_name].present? && @member.present?
			@company = Com::Nbos::StartupFundraising::Company.new
			profile_params = params[:company]
			company_profile = Com::Nbos::StartupFundraising::CompanyProfile.new(profile_params.permit!)
			@company.company_profile = company_profile
			
			if @company.save
				@member.companies << @company
				@member.save
				render :json => @company
			else
				render :json => {status: 500, message: @company.errors.messages}, status: 500
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def update_profile
		if params[:id].present? && @member.present?
			@company = @member.companies.where(id: params[:id]).first
			
			company_category = Com::Nbos::StartupFundraising::CompanyCategory.exists?(name: params[:company_category]) ? Com::Nbos::StartupFundraising::CompanyCategory.find_by(name: params[:company_category]) : nil
			company_stage = Com::Nbos::StartupFundraising::CompanyStage.exists?(name: params[:company_stage]) ? Com::Nbos::StartupFundraising::CompanyStage.find_by(name: params[:company_stage]) : nil
			currency_type = Com::Nbos::StartupFundraising::CurrencyType.exists?(code: params[:currency_type]) ? Com::Nbos::StartupFundraising::CurrencyType.find_by(code: params[:currency_type]) : nil

			@company.company_category_id = company_category.id if company_category.present?
			@company.company_stage_id = company_stage.id if company_category.present?
			@company.currency_type_id = currency_type.id if currency_type.present?
			
			profile_params = params[:company].except(:company_stage, :company_category, :currency_type)

			@company.company_profile.update(profile_params.permit!)
			if @company.save
				render :json => @company
			else
				render :json => { status: 500, message: "Internal Server Error"}, status: 500
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def show
		if params[:id].present?
			@company = Com::Nbos::StartupFundraising::Company.where(id: params[:id]).first
			if @company.present?
				render :json => @company
			else
				render :json => {status: 404, message: "Company Not Found"}, status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def update
		if params[:id].present? && @member.present?
			@company = @member.companies.where(id: params[:id]).first
			company_params = params[:company].except(:id,:controller,:action)
			if @company.update(company_params.permit!)
				render :json => @company
			else
				render :json => {status: 500, message: @company.errors.messages}, status: 500
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def delete
		if params[:id].present? && @member.present?
			@company = @member.companies.where(id: params[:id]).first
			if @company.present? && @company.destroy
				render :json => @member.companies
			else
				render :json => {status: 404, message: "Company Not Found."}, status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end
end