class Api::StartupFundraising::V0::Nbos::CompanyDocumentCategoryController < Api::StartupFundraising::V0::StartupBaseController

 def index
 	 @company_document_categories = Com::Nbos::StartupFundraising::CompanyDocumentCategory.all
 	 render :json => @company_document_categories
 end	
end