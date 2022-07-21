# frozen_string_literal: true

# This module holds all logic with user roles, which means:
#   * relations
#   * validations, which based on roles
#   * scopes
module Roles
    extend ActiveSupport::Concern
  
    included do 
      has_many :user_roles
      has_many :roles, through: :user_roles
    
      validate :validate_roles
  
      [*Role::USER_ROLES].each do |role|
        define_method :"#{role}?" do |resource = nil|
           roles.pluck(:name).include? role
        end
  
        scope role.to_s.pluralize, ->(resource = nil) { joins(:roles).where(roles: {name: role}) }
      end
    end
  
  
    private
  
    def validate_roles
    end
  
    def invalid_role(role)
      errors.add(:roles, "#{role} is not a valid role")
    end
  end
  