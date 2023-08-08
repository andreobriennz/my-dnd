class Campaign < ApplicationRecord
    belongs_to :user
    has_many :adventures
    
    before_create :set_defaults

    private

    def set_defaults
        require 'securerandom'
        self.slug = SecureRandom.hex(5)
    end
end
