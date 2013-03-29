class Project < ActiveRecord::Base

  #validations
  validates :name, :presence => true, :uniqueness => true, :length => {:maximum => 100}

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

    def active
      where(:status => true).order('name ASC')
    end
  end

end
