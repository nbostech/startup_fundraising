class Api::StartupFundraising::V0::Nbos::InvestmentCommitmentsController < Api::StartupFundraising::V0::StartupBaseController

	before_action :get_member, only: [:create, :update, :delete]

	def index
		if params[:id].present?
			@funding_round = Com::Nbos::StartupFundraising::FundingRound.where(id: params[:id]).first
			if @funding_round.present?
				render :json => @funding_round.investment_commitments
			else
				render :json => {status: 404, message: "Funding Round Not Found"}, status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def create
		if params[:id].present? && @member.present?
			@funding_round = Com::Nbos::StartupFundraising::FundingRound.where(id: params[:id]).first
			if @funding_round.present?
				investment_commitment_params = params[:investment_commitment].except(:commitmentType)
				@investment_commitment = Com::Nbos::StartupFundraising::InvestmentCommitment.new(investment_commitment_params.permit!)
				if params[:commitmentType].present?
					commitment_type = Com::Nbos::StartupFundraising::CommitmentType.where(name: params[:commitmentType])
					@investment_commitment.commitment_type_id = commitment_type.first.id if commitment_type.present?
				end
					@investment_commitment.funding_round_id = @funding_round.id
					@investment_commitment.user_id = @member.id

				if @investment_commitment.save
					@funding_round.company.is_funded = true
					@funding_round.save
					render :json => @funding_round.investment_commitments
				else
					render :json => {status: 500, message: @investment_commitment.errors.messages}, status: 500
				end
			else
				render :json => {status: 404, message: "Funding Round Not Found"},status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"},status: 400
		end
	end

	def show
		if params[:id].present?
			 @investment_commitment = Com::Nbos::StartupFundraising::InvestmentCommitment.where(id: params[:id]).first
			if @investment_commitment.present?
				render :json => @investment_commitment
			else
				render :json => {status: 404, message: "Investment Commitment Not Found"},status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"}, status: 400
		end
	end

	def update
		if params[:id].present? && @member.present?
			@investment_commitment = @member.investment_commitments.where(id: params[:id]).first
			investment_commitment_params = params[:investment_commitment].except(:commitmentType)
			if params[:commitmentType].present?
				commitment_type = Com::Nbos::StartupFundraising::CommitmentType.where(name: params[:commitmentType])
				@investment_commitment.commitment_type_id = commitment_type.first.id if commitment_type.present?
			end

			if @investment_commitment.update_columns(investment_commitment_params.permit!)
				render :json => @investment_commitment
			else
				render :json => {status: 404, message: "Investment Commitment Not Found"},status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"},status: 400
		end
	end

	def delete
		if params[:id].present? && @member.present?
			@investment_commitment = @member.investment_commitments.where(id: params[:id]).first
			if @investment_commitment.destroy 
				render :json => @member.investment_commitments
			else
				render :json => {status: 404, message: "Investment Commitment Not Found"}, status: 404
			end
		else
			render :json => {status: 400, message: "Bad Request"},status: 400
		end
	end
end