class Campaign < ApplicationRecord
    before_create :set_defaults

    belongs_to :user

    private

    def set_defaults
        require 'securerandom'
        self.slug = SecureRandom.hex(5)
    end
end
