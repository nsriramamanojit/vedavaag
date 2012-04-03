class Transaction < ActiveRecord::Base

  #relations
  has_many :deals
  accepts_nested_attributes_for :deals, :allow_destroy => true

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
