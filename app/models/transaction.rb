class Transaction < ActiveRecord::Base

  #attachment
  #other
  has_attached_file :attachment
  # before_proof_post_process :allow_only_images
  #
  #def allow_only_images
  #  if !(attachment.content_type =~ %r{^(image|(x-)?application)/(x-png|pjpeg|jpeg|jpg|png|gif)$})
  #    return false
  #  end
  #end


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
