class User < ApplicationRecord
  include Roles
  
  acts_as_paranoid

  # TODO: enable confirmable when mail sending available
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable, :trackable

  has_paper_trail

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  scope :with_roles, ->{includes(:roles)}


end
