require "json"
parsed_words = JSON.parse File.read("./python/words.json")

puts "🌱 Destroying seeds..."

User.destroy_all
Lexicon.destroy_all


puts "Creating new seeds..."

example_user = User.create(username: "example", password: "1234abcd", password_confirmation: "1234abcd")

Lexicon.create(name: "example words", words: parsed_words.join(","), user_id: example_user.id)

puts "✅ Done seeding!"
