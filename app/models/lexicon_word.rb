class LexiconWord < ActiveRecord::Base
    belongs_to :lexicon
    belongs_to :word
end