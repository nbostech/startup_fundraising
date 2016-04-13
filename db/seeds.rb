# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Creating default roles for startup fundraising module
roles = [["Moderator", "md"], ["Premium Investor", "pi"], ["Investor", "inv"], ["Startup", "cmp"], ["Member","mb"]]

if Com::Nbos::StartupFundraising::Role.all.size == 0
 roles.each do |r|
   Com::Nbos::StartupFundraising::Role.create({name: r[0], code: r[1]})
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

if Com::Nbos::StartupFundraising::Category.all.size == 0
 categories.each do |c|
   Com::Nbos::StartupFundraising::Category.create({name: c})
   puts "******#{c} Category Created."	
 end
 puts "Categories creation Completed."
end

company_stages = ["Post Revenue", "Pre Revenue"]              

# Creating default Company Stages for startup fundraising module
if Com::Nbos::StartupFundraising::CompanyStage.all.size == 0
 company_stages.each do |cs|
   Com::Nbos::StartupFundraising::CompanyStage.create({name: cs})
   puts "******#{cs} Company Stage Created."	
 end
 puts "CompanyStages creation Completed."
end	
