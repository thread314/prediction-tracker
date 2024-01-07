class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :timeoutable, :lockable
  acts_as_voter
  has_many :predictors
  has_many :predictions
  has_many :outcomes
  has_many :reports
  has_many :comments
  validates :username, presence: true, uniqueness: { case_sensitive: false }

end
