# Author: Chaitanya
# Date: 07022012
##############################################
class Role < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments

  #Validations
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100}

  #search and recent
  class << self
    def recent
      order('created_at DESC').limit(4)
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
