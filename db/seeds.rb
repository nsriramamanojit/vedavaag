session = User.create do |u|
  u.name = "Vedavaag Systems Limited"
  u.login = 'vedavaag'
  u.email = 'chaitanya@vedavaag.com'
  u.password = 'vedavaag345@'
  u.mobile_number=966613888
  Assignment.create(:user_id => 1, :role_id => 1, :created_at => Time.now, :updated_at => Time.now)
end
session.save
session = User.create do |u|
  u.name = "Administrator"
  u.login = 'admin'
  u.email = 'jmkrishna@vedavaag.com'
  u.password = 'vedavaag345@'
  u.mobile_number=9849024218
  Assignment.create(:user_id => 2, :role_id => 2, :created_at => Time.now, :updated_at => Time.now)
end
session.save
session = User.create do |u|
  u.name = "Manager"
  u.login = 'manager'
  u.email = 'sarma_pjln@vedavaag.com'
  u.password = 'vedavaag345@'
  u.mobile_number=8173004000
  Assignment.create(:user_id => 3, :role_id => 3, :created_at => Time.now, :updated_at => Time.now)
end
session.save

############# Roles ###############
Role.create(:name => "sa", :description => "Super Admin", :created_at => Time.now, :created_by => 1)
Role.create(:name => "admin", :description => "Admin", :created_at => Time.now, :created_by => 1)
Role.create(:name => "manager", :description => "Manager", :created_at => Time.now, :created_by => 1)
Role.create(:name => "employee", :description => "Employee", :created_at => Time.now, :created_by => 1)


