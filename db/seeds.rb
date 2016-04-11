# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles = [["Moderator", "md"], ["Premium Investor", "pi"], ["Investor", "inv"], ["Startup", "cmp"], ["Member","mb"]]

roles.each do |r|
  Com::Nbos::StartupFundraising::Role.create({name: r[0], code: r[1]})
  puts "******#{r} Role Created."	
end

puts "Roles creation Completed."	
