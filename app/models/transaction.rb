class Transaction < ActiveRecord::Base

  #attachment
  has_attached_file :attachment

  #validations
  validates :name,:request_amount,:description,:presence => true


  #Recent and Search
  class << self
    def recent
      order('id DESC').limit(4)
    end
    def search(query)
      if query
        where({:name.matches => "%#{query}%"}) #from meta_where gem
      else
        scoped
      end
    end
  end

end
