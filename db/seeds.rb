require "json"
parsed_words = JSON.parse File.read("./python/words.json")

puts "🌱 Destroying seeds..."

Word.destroy_all
Lexicon.destroy_all
LexiconWord.destroy_all



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
create_lexicon "example", parsed_words

puts "✅ Done seeding!"
