class Adventure < ApplicationRecord
    before_create :set_defaults

    private

    def set_defaults
        require 'securerandom'
        self.slug = SecureRandom.hex(4)
    end
end
