class Adventure < ApplicationRecord
    belongs_to :user
    # has_many :comment, dependent: :destroy
    has_many :comments, as: :commentable, dependent: :destroy

    before_create :set_defaults

    validates :title, presence: true
    validates :user_id, presence: true
    validates :slug, uniqueness: true

    private

    def set_defaults
        require 'securerandom'
        self.slug ||= SecureRandom.hex(4) # set only if doesn't exist
        # self.user_id ||= Current.user.id
    end
end
