# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

 token = WavelabsClientApi::Client::Api::Core::AuthApi.new.get_auth_token("client_credentials", [])
 m_token = WavelabsClientApi::Client::Api::Core::AuthApi.new().get_auth_token("client_credentials", "scope:oauth.token.verify", ENV["MODULE_API_SERVER_CLIENT_ID"], ENV["MODULE_API_SERVER_CLIENT_SECRET"]) 
 token_res1 = WavelabsClientApi::Client::Api::Core::AuthApi.new().is_token_valid(token[:token].value, m_token[:token].value)
puts "#{token_res1}"
# Creating default roles for startup fundraising module
roles = [["Moderator", "md"], ["Premium Investor", "pi"], ["Investor", "inv"], ["Startup", "cmp"], ["Member","mb"]]

if Com::Nbos::StartupFundraising::Role.all.size == 0
 roles.each do |r|
   Com::Nbos::StartupFundraising::Role.create({name: r[0], code: r[1], tenant_id: token_res1[:token].tenantId})
   puts "******#{r} Role Created."	
 end
 puts "Roles creation Completed."
end

# Creating default Company Catogories for startup fundraising module
categories = ["Aerospace", "Agriculture", "Biotechnology", "BusinessProducts", "BusinessServices",
              "Chemicals&Chemical Products", "CleanTechnology", "Computers&Peripherals",
              "Construction", "Consulting", "ConsumerProducts", "ConsumerServices", "DigitalMarketing",
              "Education", "Electronics/Instrumentation", "Fashion", "FinancialServices", "Fintech",
              "Food&Beverage", "Gaming", "HealthcareServices", "Industrial/Energy", "Internet/WebServices",
              "ITServices", "Legal", "Lifestyle", "Marine", "Maritime/Shipping", "Marketing/Advertising",
              "Media&Entertainment", "MedicalDevices&Equipment", "Mining", "Mobile", "Nanotechnology",
              "Networking&Equipment", "Oil&Gas", "Other", "RealEstate", "Retailing/Distribution",
              "Robotics", "Security", "Semiconductors", "Software", "Sports", "Telecommunications", "Transportation",
              "Travel"
             ]

if Com::Nbos::StartupFundraising::CompanyCategory.all.size == 0
 categories.each do |c|
   Com::Nbos::StartupFundraising::CompanyCategory.create({name: c, tenant_id: token_res1[:token].tenantId})	
 end
 puts "Categories creation Completed."
end

company_stages = ["Prototype", "Operational", "Growth"]              

# Creating default Company Stages for startup fundraising module
if Com::Nbos::StartupFundraising::CompanyStage.all.size == 0
 company_stages.each do |cs|
   Com::Nbos::StartupFundraising::CompanyStage.create({name: cs, tenant_id: token_res1[:token].tenantId})
 end
 puts "CompanyStages creation Completed."
end

currency_type = [["INR", "Rs"],["USD", "$"]]

# Creating Initial Currency Types
if Com::Nbos::StartupFundraising::CurrencyType.all.size == 0
 currency_type.each do |ct|
   Com::Nbos::StartupFundraising::CurrencyType.create({code: ct[0], symbol: ct[1], tenant_id: token_res1[:token].tenantId}) 
 end
 puts "Currency Type creation Completed."
end

associate_teams = ["CoreTeam", "Advisor", "PreviousInvestor"]

# Creating Initial Associated Teams
if Com::Nbos::StartupFundraising::AssociateTeam.all.size == 0
 associate_teams.each do |at|
   Com::Nbos::StartupFundraising::AssociateTeam.create({name: at, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Associated Teams creation Completed."
end

document_types = ["BusinessPlan", "FinancialProjections", "SupplementalDocuments", "PitchDeck", "PitchDeckVideo"]

# Creating Initial Document Types
if Com::Nbos::StartupFundraising::DocumentType.all.size == 0
 document_types.each do |cdt|
   Com::Nbos::StartupFundraising::DocumentType.create({name: cdt, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Document Types creation Completed."
end

company_summary_types = ["ManagementTeam", "CustomerProblem", "Products&Services",
                         "TargetMarket", "BusinessModel", "CustomerSegments", "Sales&MarketingStrategy",
                         "Competitors", "CompetitiveAdvantage"]

# Creating Initial Company Summary Types
if Com::Nbos::StartupFundraising::CompanySummaryType.all.size == 0
 company_summary_types.each do |cst|
   Com::Nbos::StartupFundraising::CompanySummaryType.create({name: cst, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Company Summary Types creation Completed."
end

address_types = ["HeadOffice", "BranchOffice", "Communication"]
# Creating Initial Address Types
if Com::Nbos::StartupFundraising::AddressType.all.size == 0
 address_types.each do |at|
   Com::Nbos::StartupFundraising::AddressType.create({name: at, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Address Types creation Completed."
end

funding_round_types = ["Founder", "Seed", "Family&Friends"]
# Creating Initial Funding Round Types
if Com::Nbos::StartupFundraising::FundingRoundType.all.size == 0
 funding_round_types.each do |at|
   Com::Nbos::StartupFundraising::FundingRoundType.create({name: at, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Funding Round Types creation Completed."
end

domain_expertises = ["Sales&Marketing", "Technology", "BusinessStrategy", "Finance&Legal", "Production&Design"]
sub_domain_expertises_for_sales = ["Advertising", "Branding", "ContentMarketing", "CustomProcess","CustomerEngagement", "CustomerRelationships", "DistributionChannels", "GrowthHacking", "LeadGeneration", "Negotiations", "PR&Media", "PromoMaterials", "SalesTechniques", "SEO&DigitalMarketing", "SocialMediaMarketing", "Strategies&Training"]
sub_domain_expertises_for_technologies = ["AgroTech", "Cloud", "Construction", "CRM", "Electrical", "FashonTech", "FoodTech", "Mechanical", "SoftwareDevelopment", "Solar&CleanTech", "Web&MobileApp"]
sub_domain_expertises_for_business_strategies = ["BusinessModel", "BusinessPlans",  "Expansion/ScalingUp", "GotoMarket", "HRStrategies", "IdeatoPrototype", "IdeaValidation", "Logistics", "OperationsStrategy", "PitchDeck", "Revenue&PricingModel", "SupplyChainManagement", "WebAnalytics"]
sub_domain_expertises_for_finance_and_legal = ["FinancialModel", "Finance&Accounting", "FundRaising", "CompanyIncorporation", "Statutory&Legal", "Patents,Trademarks&Copyrights"]
sub_domain_expertises_for_product_and_design = ["UI/UX", "ProductManagement", "ProductDesign", "ProductDevelopment"]
# Creating Initial Funding Round Types
if Com::Nbos::StartupFundraising::DomainExpertise.all.size == 0
 domain_expertises.each do |de|
   Com::Nbos::StartupFundraising::DomainExpertise.create({name: de, tenant_id: token_res1[:token].tenantId})  
 end
 parent_id = Com::Nbos::StartupFundraising::DomainExpertise.where(name: "Sales&Marketing").first.id
 sub_domain_expertises_for_sales.each do |sm|
   Com::Nbos::StartupFundraising::DomainExpertise.create({name: sm, tenant_id: token_res1[:token].tenantId, parent_id: parent_id})  
 end

 parent_id = Com::Nbos::StartupFundraising::DomainExpertise.where(name: "Technology").first.id
 sub_domain_expertises_for_technologies.each do |tc|
   Com::Nbos::StartupFundraising::DomainExpertise.create({name: tc, tenant_id: token_res1[:token].tenantId, parent_id: parent_id})  
 end

 parent_id = Com::Nbos::StartupFundraising::DomainExpertise.where(name: "BusinessStrategy").first.id
 sub_domain_expertises_for_business_strategies.each do |bs|
   Com::Nbos::StartupFundraising::DomainExpertise.create({name: bs, tenant_id: token_res1[:token].tenantId, parent_id: parent_id})  
 end

 parent_id = Com::Nbos::StartupFundraising::DomainExpertise.where(name: "Finance&Legal").first.id
 sub_domain_expertises_for_finance_and_legal.each do |fl|
   Com::Nbos::StartupFundraising::DomainExpertise.create({name: fl, tenant_id: token_res1[:token].tenantId, parent_id: parent_id})  
 end

 parent_id = Com::Nbos::StartupFundraising::DomainExpertise.where(name: "Production&Design").first.id
 sub_domain_expertises_for_product_and_design.each do |pd|
   Com::Nbos::StartupFundraising::DomainExpertise.create({name: pd, tenant_id: token_res1[:token].tenantId, parent_id: parent_id})  
 end  
end

commitment_types = ["Soft", "Commited"]
# Creating Initial Funding Round Types
if Com::Nbos::StartupFundraising::CommitmentType.all.size == 0
 commitment_types.each do |ct|
   Com::Nbos::StartupFundraising::CommitmentType.create({name: ct, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Commitment Types creation Completed."
end

