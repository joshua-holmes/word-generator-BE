class Word < ActiveRecord::Base
    has_many :lexicon_words
    has_many :lexicons, through: :lexicon_words
end