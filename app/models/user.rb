class User < ApplicationRecord
    has_secure_password
    has_many :campaigns, dependent: :destroy

    validates :email, presence: true
    validates :username, presence: true
end
