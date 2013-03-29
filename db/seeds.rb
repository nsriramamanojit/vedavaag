session = User.create do |u|
  u.name = "Vedavaag Systems Limited"
  u.login = 'vedavaag'
  u.email = 'nchaitanyaram@gmail.com'
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
  u.email = 'sarma_pjln@hotmail.com'
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
Role.create(:name => "am", :description => "Account Manager", :created_at => Time.now, :created_by => 1)

######### States #################
State.create(:name => "Andhra Pradesh", :description => "AP", :created_at => Time.now, :created_by => 1,:status=>1)
State.create(:name => "Bihar", :description => "Bihar", :created_at => Time.now, :created_by => 1,:status=>1)
State.create(:name => "Uttar Pradesh", :description => "UP", :created_at => Time.now, :created_by => 1,:status=>1)

######### Projects #################
Project.create(:name => "Vedavaag", :description => "Vedavaag", :created_at => Time.now, :created_by => 1,:status=>1)
Project.create(:name => "SECC-UP", :description => "SECC UP", :created_at => Time.now, :created_by => 1,:status=>1)
Project.create(:name => "SECC-BIHAR", :description => "SECC BIHAR", :created_at => Time.now, :created_by => 1,:status=>1)
Project.create(:name => "NPR40-ITI", :description => "NPR40 ITI", :created_at => Time.now, :created_by => 1,:status=>1)
Project.create(:name => "NPR40-BEL", :description => "NPR40 BEL", :created_at => Time.now, :created_by => 1,:status=>1)
Project.create(:name => "NPR40-ECIL", :description => "NPR40 ECIL", :created_at => Time.now, :created_by => 1,:status=>1)




