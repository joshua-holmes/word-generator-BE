puts "🌱 Destroying seeds..."

User.destroy_all
Dictionary.destroy_all


puts "Creating new seeds..."

example_user = User.create(username: "example", password: "1234abcd", password_confirmation: "1234abcd")

Dictionary.create(name: "example words", words: "hi,hey,howdy", user_id: example_user.id)

puts "✅ Done seeding!"
