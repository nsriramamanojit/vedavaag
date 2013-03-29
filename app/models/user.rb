class User < ActiveRecord::Base
  #Authlogic Configuration
  acts_as_authentic do |c|
    c.validate_email_field = false
    c.require_password_confirmation= false
    c.validate_password_field= false
    #c.login_field=false
    #c.validate_login_field=false
  end
  #Relations
  has_many :assignments
  has_many :roles, :through => :assignments
  belongs_to :state
  belongs_to :project

  #Roles
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end

  #validations
  validates :name, :presence => true, :length => {:maximum => 100}
  validates :mobile_number, :presence => true, :length => {:maximum => 10}
  validates :login,:presence => true,:length => {:maximum => 20},:uniqueness => true
  validates :email,:presence => true,:uniqueness => true

  #Recent and Search
  class << self
    def recent
      order('id DESC').limit(4)
    end
    def search(query)
      if query
        where(:name.matches => "%#{query}%") #from meta_where gem
      else
        scoped
      end
    end
  end
end
