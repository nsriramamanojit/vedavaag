session = User.create do |u|
  u.name = "Vedavaag Systems Limited"
  u.login = 'vedavaag'
  u.email = 'sarma_pjln@vedavaag.com'
  u.password = 'vedavaag345@'
  u.mobile_number=9885976490
  Assignment.create(:user_id => 1, :role_id => 1, :created_at => Time.now, :updated_at => Time.now)
end
session.save
############# Roles ###############
Role.create(:name => "admin", :description => "admin", :created_at => Time.now, :created_by => 1)
Role.create(:name => "employee", :description => "Employee", :created_at => Time.now, :created_by => 1)


