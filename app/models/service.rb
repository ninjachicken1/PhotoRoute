class Service < ActiveRecord::Base
  FLICKR = 0
  
  # Associations
  belongs_to :user
  
  # Validations
  validates_presence_of :service_type, :service_uname
end
