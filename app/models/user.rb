class User < ApplicationRecord
  include Roles
  
  # TODO: enable confirmable when mail sending available
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable, :trackable

  has_paper_trail





end
