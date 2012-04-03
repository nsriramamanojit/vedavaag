class Account < ActiveRecord::Base
  #validations
  validates :name, :presence => true
  validates :account_number,:presence => true,:uniqueness => true


  #Recent and Search
  class << self
    def recent
      order('id DESC').limit(4)
    end
    def search(query)
      if query
        where({:name.matches => "%#{query}%"} | {:account_number.matches => "%#{query}%"}) #from meta_where gem
      else
        scoped
      end
    end
  end

end
