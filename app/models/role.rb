class Role < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    USER_ROLES = %w[
        user
        admin
      ].freeze

end
