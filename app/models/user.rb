class User < ActiveRecord::Base
	has_many :books
	has_many :reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
