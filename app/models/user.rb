class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy
  
  validates :email, presence:true, uniqueness: true
  validates_format_of :email, with: /@/
  validates :password_digest, presence: true
  validates :fullname, presence: true, length: {minimum:8}
end
