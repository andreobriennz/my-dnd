class Adventure < ApplicationRecord
    belongs_to :user

    before_create :set_defaults

    private

    def set_defaults
        require 'securerandom'
        self.slug = SecureRandom.hex(4)
        self.user_id = Current.user.id
    end
end
