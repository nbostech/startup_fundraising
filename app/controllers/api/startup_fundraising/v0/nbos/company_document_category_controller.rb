class Api::StartupFundraising::V0::Nbos::CompanyDocumentCategoryController < Api::StartupFundraising::V0::StartupBaseController
before_action :validate_token
 def index
 	 @company_document_categories = Com::Nbos::StartupFundraising::DocumentType.all
 	 render :json => @company_document_categories
 end	
end