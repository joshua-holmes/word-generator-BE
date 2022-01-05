class FavoriteWord < ActiveRecord::Base
    belongs_to :lexicon
    belongs_to :fake_word
end