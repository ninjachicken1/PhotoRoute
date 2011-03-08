require 'digest/sha1'

class User < ActiveRecord::Base
  # Associations
  has_many :services
  has_many :paths
  has_many :waypoints
  
  # Validations
  validates_uniqueness_of   :name
  validates_presence_of     :name
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  validate :password_non_blank
  
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = User.encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    old_pwd = self.hashed_password
    self.hashed_password = User.encrypted_password(self.password, self.salt)
    puts "***** Made it past password= setter, old(#{old_pwd}), new(#{self.hashed_password})"
  end

private
  
  def password_non_blank
    errors.add(:password, "Missing password") if hashed_password.blank?
  end
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end
