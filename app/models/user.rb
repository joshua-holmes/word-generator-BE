class User < ActiveRecord::Base
    has_many :dictionaries
    has_secure_password
end