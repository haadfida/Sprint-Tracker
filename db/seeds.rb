# <<<<<<< HEAD
# # <<<<<<< HEAD
# # # <<<<<<< HEAD
# # # =======
# # # # This file should contain all the record creation needed to seed the database with its default values.
# # # # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# # # #
# # # # Examples:
# # # #
# # # #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# # # #   Character.create(name: 'Luke', movie: movies.first)

# # # >>>>>>> 5e3928fe934fe9932eee57eda8884bdffed98d0d
# STATUS = { 1 => 'open', 2 => "in_progress", 3 => 'resolved', 4 => 'closed'}.freeze

# VALID_STATUSES = { 1 => 'Planning', 2 => 'Active', 3 => 'Closed'}.freeze

# Company.create([{ name: '90Vals', subdomain: '90vals', owner_id: nil },
#                 { name: '7Vals', subdomain: '7vals', owner_id: nil }])
# Company.current_company_id = 1

# owner = User.create!(email: 'zain@gmail.com', password: '123456', role_id: 1, phone_num: "123456", name: "haider")
# Company.current_company.update(owner: owner)

# (0..100).each do |i|
#   val = Faker::Company.name
#   company = Company.create!(name: val, subdomain: val, owner_id: nil)
#   company.update(owner: owner)
#   c = Company.unscoped.all
#   user = User.create!(email: "haider#{i}@8vals.com", password: '123456', role_id: 2, phone_num: "1233456#{i}}", name: Faker::Name.name, company: c[rand(0..i)])
# end

# (1..100).each do |i|
#   company = rand(1..100)
#   Company.current_company_id = company
#   u = User.all
#   unless u.blank?
#     Project.create!(name: Faker::Company.name, start_date: Time.now, end_date: 5.day.from_now, manager: u[rand(1..u.count)-1], creator: u[rand(1..u.count)-1], company_id: company)
#   end
# end

# (1..100).each do |i|
#   Company.current_company_id = 1
#   u = User.all
#   p = Project.all
#   unless p.blank?
#     user = u[rand(1..u.count)-1]
#     unless user.blank? and u.blank?
#       issue = Issue.create!(title: Faker::Company.name, description: Faker::Quote.matz, estimated_time: "100.00", status: STATUS[rand(1..4)], priority: 'high', category: 'hotfix', actual_start_date: rand(1..15).days.ago, actual_end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,  creator: user, assignee_id: u[rand(1..u.count)-1].id, reviewer_id: u[rand(1..u.count)-1].id, project: p[rand(1..p.count)-1])

#       (0..rand(1..10)).each do |i|
#         user = u[rand(1..u.count)-1]
#         TimeLog.create!(date: rand(1..15).days.ago, logged_time: Faker::Number.between(from: 0.0, to: 100.0).round(2) , work_description: Faker::Quote.matz, assignee: user, issue:issue)

#       end
#       # pu = ProjectsUser.new(project: p[rand(1..p.count)-1], user: u[rand(1..u.count)-1])
#       # pu.save(validate: false)
#     end
#   end

# end
# # =======
# # end

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       binding.pry
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(1..15).days.ago,
# # #                      end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..4)])
# # #     end
# # #   end
# # # end

# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all

# # #   unless p.blank?
# # #     unless user.blank? and u.blank?
# # #       user = u[rand(1..u.count)-1]
# # #       user = u[rand(1..u.count)]
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-15..0).days.ago,
# # #                      end_date: rand(-30..-16).days.ago, estimated_start_date: rand(-15..0).days.ago, estimated_end_date: rand(-30..-16).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end

# # # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-29..-16).days.ago,
# # #                      end_date: rand(-45..-30).days.ago, estimated_start_date: rand(-29..-16).days.ago, estimated_end_date: rand(-45..-30).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end

# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-44..-29).days.ago,
# # #                      end_date: rand(-60..-45).days.ago, estimated_start_date: rand(-44..-29).days.ago, estimated_end_date: rand(-60..-45).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end
# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-59..-44).days.ago,
# # #                      end_date: rand(-75..-60).days.ago, estimated_start_date: rand(-59..-44).days.ago, estimated_end_date: rand(-75..-60).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end

# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-74..-59).days.ago,
# # #                      end_date: rand(-90..-75).days.ago, estimated_start_date: rand(-74..-59).days.ago, estimated_end_date: rand(-90..-75).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end

# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(30..44).days.ago,
# # #                      end_date: rand(15..29).days.ago, estimated_start_date: rand(30..44).days.ago, estimated_end_date: rand(15..29).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end

# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(60..74).days.ago,
# # #                      end_date: rand(45..59).days.ago, estimated_start_date: rand(60..74).days.ago, estimated_end_date: rand(45..59).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end

# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(90..104).days.ago,
# # #                      end_date: rand(75..89).days.ago, estimated_start_date: rand(90..104).days.ago, estimated_end_date: rand(75..89).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end


# # # binding.pry

# # # (0..1000).each do |i|
# # #   company = rand(1..100)
# # #   Company.current_company_id = company
# # #   u = User.all
# # #   p = Project.all
# # #   unless p.blank?
# # #     user = u[rand(1..u.count)-1]
# # #     unless user.blank? and u.blank?
# # #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(120..134).days.ago,
# # #                      end_date: rand(105..119).days.ago, estimated_start_date: rand(120..134).days.ago, estimated_end_date: rand(105..119).days.ago,
# # #                      project: p[rand(1..p.count) -1], creator: user)
# # #     end
# # #   end
# # # end

# # # binding.pry
# # >>>>>>> 5e3928fe934fe9932eee57eda8884bdffed98d0d
# # =======
# # # This file should contain all the record creation needed to seed the database with its default values.
# # # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# # #
# # # Examples:
# # #
# # #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# # #   Character.create(name: 'Luke', movie: movies.first)

# # STATUS = { 1 => 'Open', 2 => 'In Progress', 3 => 'Resolved', 4 => 'Closed' }.freeze

# # VALID_STATUSES = { 1 => 'PLANNING', 2 => 'ACTIVE', 3 => 'CLOSED' }.freeze

# # Company.create([{ name: '8Vals', subdomain: '8vals', owner_id: nil },
# #                 { name: '7Vals', subdomain: '7vals', owner_id: nil }])
# # Company.current_company_id = 1

# # owner = User.create!(email: 'haider@gmail.com', password: '123456', role_id: 1, phone_num: "123456", name: "haider")
# # Company.current_company.update(owner: owner)

# # (0..100).each do |i|
# #   val = Faker::Company.name
# #   company = Company.create!(name: val, subdomain: val, owner_id: nil)
# #   company.update(owner: owner)
# #   c = Company.unscoped.all
# #   user = User.create!(email: "haider#{i}@8vals.com", password: '123456', role_id: 2, phone_num: "1233456#{i}}", name: Faker::Name.name, company: c[rand(0..i)])
# # end

# # (1..100).each do |i|
# #   company = rand(1..100)
# =======
# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# STATUS = { 1 => :open, 2 => :in_progress, 3 => :resolved }.freeze
# PRIORITY = { 1 => :low, 2 => :medium, 3 => :high }.freeze
# CATEGORY = { 1 => :hotfix, 2 => :feature }.freeze
# VALID_STATUSES = { 1 => 'PLANNING' }.freeze

# Company.create([{ name: '8Vals', subdomain: '8vals', owner_id: nil },
#                 { name: '7Vals', subdomain: '7vals', owner_id: nil }])
# Company.current_company_id = 1

# owner = User.new(email: 'haider@gmail.com', password: '123456', role_id: 1, phone_num: "123456789", name: "haider")
# owner.skip_confirmation!
# owner.save!
# Company.current_company.update(owner: owner)

# (0..50).each do |i|
#   val = Faker::Company.name
#   company = Company.create!(name: val, subdomain: val, owner_id: nil)
#   company.update(owner: owner)
# end

# Company.unscoped.all.each do |c|
#   (1..20).each do |i|
#     user = User.new(email: "haider#{i}@8vals.com", password: '123456', role_id: 2, phone_num: "1233456#{i}}", name: Faker::Name.name, company: c)
#     user.skip_confirmation!
#     user.save!
#   end
# end

# <<<<<<< HEAD
# # (1..500).each do |i|
# #   company = rand(1..50)
# >>>>>>> 1620fe16fb0f85fc682d191e44fbe012eea483b1
# #   Company.current_company_id = company
# #   u = User.all
# #   unless u.blank?
# #     Project.create!(name: Faker::Company.name, start_date: Time.now, end_date: 5.day.from_now, manager: u[rand(1..u.count)-1], creator: u[rand(1..u.count)-1], company_id: company)
# #   end
# # end
# =======
# (1..100).each do |i|
#   company = rand(1..50)
#   Company.current_company_id = company
#   u = User.all
#   unless u.blank?
#     Project.create!(name: Faker::Company.name, start_date: Time.now, end_date: 5.day.from_now, manager: u[rand(1..u.count)-1], creator: u[rand(1..u.count)-1], company_id: company)
#   end
# end
# >>>>>>> 63f163901f88476a8500f41cf0465dcf87d37455

# <<<<<<< HEAD
# # (0..5000).each do |i|
# #   company = rand(0..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       issue = Issue.create!(title: Faker::Company.name, description: Faker::Quote.matz, estimated_time: "100.00", status: STATUS[rand(1..4)], priority: "High", category: "Hotfix", actual_start_date: rand(1..15).days.ago, actual_end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,  creator: user, assignee_id: u[rand(1..u.count)-1].id, reviewer_id: u[rand(1..u.count)-1].id, project: p[rand(1..p.count)-1])

# #       (0..rand(1..10)).each do |i|
# #         user = u[rand(1..u.count)-1]
# #         TimeLog.create!(date: rand(1..15).days.ago, logged_time: Faker::Number.between(from: 0.0, to: 100.0).round(2) , work_description: Faker::Quote.matz, assignee: user, issue:issue)

# #       end
# #       # pu = ProjectsUser.new(project: p[rand(1..p.count)-1], user: u[rand(1..u.count)-1])
# #       # pu.save(validate: false)
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?

# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(1..15).days.ago,
# #                      end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all

# #   unless p.blank?
# #     unless user.blank? and u.blank?
# #       user = u[rand(1..u.count)-1]
# #       user = u[rand(1..u.count)]
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-15..0).days.ago,
# #                      end_date: rand(-30..-16).days.ago, estimated_start_date: rand(-15..0).days.ago, estimated_end_date: rand(-30..-16).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-29..-16).days.ago,
# #                      end_date: rand(-45..-30).days.ago, estimated_start_date: rand(-29..-16).days.ago, estimated_end_date: rand(-45..-30).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-44..-29).days.ago,
# #                      end_date: rand(-60..-45).days.ago, estimated_start_date: rand(-44..-29).days.ago, estimated_end_date: rand(-60..-45).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-59..-44).days.ago,
# #                      end_date: rand(-75..-60).days.ago, estimated_start_date: rand(-59..-44).days.ago, estimated_end_date: rand(-75..-60).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-74..-59).days.ago,
# #                      end_date: rand(-90..-75).days.ago, estimated_start_date: rand(-74..-59).days.ago, estimated_end_date: rand(-90..-75).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(30..44).days.ago,
# #                      end_date: rand(15..29).days.ago, estimated_start_date: rand(30..44).days.ago, estimated_end_date: rand(15..29).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(60..74).days.ago,
# #                      end_date: rand(45..59).days.ago, estimated_start_date: rand(60..74).days.ago, estimated_end_date: rand(45..59).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(90..104).days.ago,
# #                      end_date: rand(75..89).days.ago, estimated_start_date: rand(90..104).days.ago, estimated_end_date: rand(75..89).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..100)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(120..134).days.ago,
# #                      end_date: rand(105..119).days.ago, estimated_start_date: rand(120..134).days.ago, estimated_end_date: rand(105..119).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[rand(1..3)])
# #     end
# #   end
# # end
# =======
# (0..5000).each do |i|
#   company = rand(0..50)
#   Company.current_company_id = company
#   u = User.all
#   p = Project.all
#   unless p.blank?
#     user = u[rand(1..u.count)-1]
#     unless user.blank? and u.blank?
#       issue = Issue.create!(title: Faker::Company.name, description: Faker::Quote.matz, estimated_time: "100.00", status: STATUS[rand(1..3)], priority: PRIORITY[rand(1..3)], category: CATEGORY[rand(1..2)], actual_start_date: rand(1..15).days.ago, actual_end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,  creator: user, assignee_id: u[rand(1..u.count)-1].id, reviewer_id: u[rand(1..u.count)-1].id, project: p[rand(1..p.count)-1])

#       (0..rand(1..10)).each do |i|
#         user = u[rand(1..u.count)-1]
#         TimeLog.create!(date: rand(1..15).days.ago, logged_time: Faker::Number.between(from: 1.0, to: 100.0).round(2) , work_description: Faker::Quote.matz, assignee: user, issue:issue)
#       end
#       # pu = ProjectsUser.new(project: p[rand(1..p.count)-1], user: u[rand(1..u.count)-1])
#       # pu.save(validate: false)
#     end
#   end
# end

# (0..1000).each do |i|
#   company = rand(1..50)
#   Company.current_company_id = company
#   u = User.all
#   p = Project.all
#   unless p.blank?
#     user = u[rand(1..u.count)-1]
#     unless user.blank? and u.blank?

#       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(1..15).days.ago,
#                      end_date: rand(-15..0).days.ago, estimated_start_date: rand(1..15).days.ago, estimated_end_date: rand(-15..0).days.ago,
#                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
#     end
#   end
# end


# # (0..5000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   i = Issue.all
# #   s = Sprint.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?

# #       Sprintreport.create!(sprint: s[rand(1..s.count) -1], issue: i[rand(1..i.count) -1], status: VALID_STATUSES[1])
# #     end
# #   end
# # end


# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all

# #   unless p.blank?
# #     unless user.blank? and u.blank?
# #       user = u[rand(1..u.count)-1]
# #       user = u[rand(1..u.count)]
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-15..0).days.ago,
# #                      end_date: rand(-30..-16).days.ago, estimated_start_date: rand(-15..0).days.ago, estimated_end_date: rand(-30..-16).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-29..-16).days.ago,
# #                      end_date: rand(-45..-30).days.ago, estimated_start_date: rand(-29..-16).days.ago, estimated_end_date: rand(-45..-30).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-44..-29).days.ago,
# #                      end_date: rand(-60..-45).days.ago, estimated_start_date: rand(-44..-29).days.ago, estimated_end_date: rand(-60..-45).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-59..-44).days.ago,
# #                      end_date: rand(-75..-60).days.ago, estimated_start_date: rand(-59..-44).days.ago, estimated_end_date: rand(-75..-60).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(-74..-59).days.ago,
# #                      end_date: rand(-90..-75).days.ago, estimated_start_date: rand(-74..-59).days.ago, estimated_end_date: rand(-90..-75).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# <<<<<<< HEAD
# (0..1000).each do |i|
#   company = rand(1..50)
#   Company.current_company_id = company
#   u = User.all
#   p = Project.all
#   unless p.blank?
#     user = u[rand(1..u.count)-1]
#     unless user.blank? and u.blank?
#       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(120..134).days.ago,
#                      end_date: rand(105..119).days.ago, estimated_start_date: rand(120..134).days.ago, estimated_end_date: rand(105..119).days.ago,
#                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
#     end
#   end
# end
# >>>>>>> 1620fe16fb0f85fc682d191e44fbe012eea483b1
# =======
# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(30..44).days.ago,
# #                      end_date: rand(15..29).days.ago, estimated_start_date: rand(30..44).days.ago, estimated_end_date: rand(15..29).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(60..74).days.ago,
# #                      end_date: rand(45..59).days.ago, estimated_start_date: rand(60..74).days.ago, estimated_end_date: rand(45..59).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(90..104).days.ago,
# #                      end_date: rand(75..89).days.ago, estimated_start_date: rand(90..104).days.ago, estimated_end_date: rand(75..89).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end

# # (0..1000).each do |i|
# #   company = rand(1..50)
# #   Company.current_company_id = company
# #   u = User.all
# #   p = Project.all
# #   unless p.blank?
# #     user = u[rand(1..u.count)-1]
# #     unless user.blank? and u.blank?
# #       Sprint.create!(name: Faker::Company.name, description: Faker::Quote.matz, start_date: rand(120..134).days.ago,
# #                      end_date: rand(105..119).days.ago, estimated_start_date: rand(120..134).days.ago, estimated_end_date: rand(105..119).days.ago,
# #                      project: p[rand(1..p.count) -1], creator: user, status: VALID_STATUSES[1])
# #     end
# #   end
# # end
# >>>>>>> 63f163901f88476a8500f41cf0465dcf87d37455
