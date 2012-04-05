class Transaction < ActiveRecord::Base

  #relations
  has_many :deals

  #attachment
  has_attached_file :attachment

  #validations
  validates :name,:transfer_account, :transfer_branch_code,:presence => true


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
