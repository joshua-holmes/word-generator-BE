require "json"
parsed_words = JSON.parse File.read("./python/words.json")

puts "🌱 Destroying seeds..."

Word.destroy_all
Lexicon.destroy_all
LexiconWord.destroy_all
FakeWord.destroy_all
FavoriteWord.destroy_all



puts "Creating new seeds..."
def create_lexicon name, words
    lex = Lexicon.create(name: name)
    words.each do |word|
        if Word.find_by(word: word)
            saved_word = Word.find_by(word: word)
        else
            saved_word = Word.create(word: word)
        end
        LexiconWord.create(lexicon_id: lex.id, word_id: saved_word.id)
    end
end
def favorite_word fake_word, lexiconName
    lexicon = Lexicon.find_by(name: lexiconName)
    word = FakeWord.find_by(word: fake_word) || FakeWord.create(word: fake_word)
    FavoriteWord.create(fake_word_id: word.id, lexicon_id: lexicon.id)
end

create_lexicon "example", parsed_words
favorite_word "jsofhi", "example"
favorite_word "dfsdf", "example"
favorite_word "qwertys", "example"
favorite_word "asdfzxcv", "example"
favorite_word "hawegsd", "example"
favorite_word "dfweeeeeee", "example"


puts "✅ Done seeding!"
