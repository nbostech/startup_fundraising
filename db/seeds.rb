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
categories = ["Aerospace", "Agriculture", "Biotechnology", "Business Products", "Business Services",
              "Chemicals and Chemical Products", "Clean Technology", "Computers and Peripherals",
              "Construction", "Consulting", "Consumer Products", "Consumer Services", "Digital Marketing",
              "Education", "Electronics / Instrumentation", "Fashion", "Financial Services", "Fintech",
              "Food and Beverage", "Gaming", "Healthcare Services", "Industrial/Energy", "Internet / Web Services",
              "IT Services", "Legal", "Lifestyle", "Marine", "Maritime/Shipping", "Marketing / Advertising",
              "Media and Entertainment", "Medical Devices and Equipment", "Mining", "Mobile", "Nanotechnology",
              "Networking and Equipment", "Oil and Gas", "Other", "Real Estate", "Retailing / Distribution",
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

associate_teams = ["Core", "Advisor", "Previous Investor"]

# Creating Initial Associated Teams
if Com::Nbos::StartupFundraising::AssociateTeam.all.size == 0
 associate_teams.each do |at|
   Com::Nbos::StartupFundraising::AssociateTeam.create({name: at, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Associated Teams creation Completed."
end

document_types = ["Business Plan", "Financial Projections", "Supplemental Documents"]

# Creating Initial Associated Teams
if Com::Nbos::StartupFundraising::CompanyDocumentCategory.all.size == 0
 document_types.each do |cdt|
   Com::Nbos::StartupFundraising::CompanyDocumentCategory.create({name: cdt, tenant_id: token_res1[:token].tenantId})  
 end
 puts "Document Types creation Completed."
end


