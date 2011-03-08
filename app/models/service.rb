class Service < ActiveRecord::Base
  # Associations
  belongs_to :user
  
  # Validations
  validates_presence_of :service_type, :service_uname, :service_pwd
end
