class User < ApplicationRecord

    has_many :transactions

    validates :email_address, uniqueness: true
    
    has_secure_password
    
end
