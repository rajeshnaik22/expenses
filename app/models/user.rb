class User < ApplicationRecord
  # TODO: enable confirmable when mail sending available
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable, :trackable

  has_paper_trail
end
