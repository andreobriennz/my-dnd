class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true # belongs to either Adventure or Campaign
    belongs_to :user

    validates :text, presence: true
end
