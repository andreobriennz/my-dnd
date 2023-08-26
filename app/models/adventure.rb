class Adventure < ApplicationRecord
    belongs_to :campaign
    has_many :comments, as: :commentable, dependent: :destroy

    before_create :set_defaults

    validates :title, presence: true
    validates :slug, uniqueness: true

    def user_id
        campaign.user_id
    end

    private

    def set_defaults
        require 'securerandom'
        self.slug ||= SecureRandom.hex(4) # set only if doesn't exist
    end
end
