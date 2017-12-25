class User < ApplicationRecord
	  before_save { self.email = email.downcase } #standardize lower case saving in database
	  validates :name, presence: true, length: {maximum: 50}
	  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	  validates :email, presence: true, length: {maximum: 255}, 
	  format: {with: VALID_EMAIL_REGEX}, 
	uniqueness: {case_sensitive: false} #same letters used= not unique
	has_secure_password 
	validates :password, presence: true, length: {minimum: 6}
	#validates :password_confirmation, presence: true, length: {minimum: 6} #not necessary checks

end
 