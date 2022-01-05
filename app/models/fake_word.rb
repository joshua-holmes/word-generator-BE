class FakeWord < ActiveRecord::Base
    has_many :favorite_words
    has_many :lexicons, through: :favorite_words
end