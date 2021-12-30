class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    "Welcome!!
    /random_word will generate a random word between 3 and 9 (inclusive) characters long
    /random_word/7 will generate a random word 7 characters long
    /random_word/5 will generate a random word 5 characters long
    /random_word/0 will generate a random word that ends when letter combinations can no longer be found in the dictionary (not recommended)
    20 characters is the maximum acceptable word length"
  end

  get "/random_word" do
    word = Lexicon.first.get_word
    [word].to_json
  end

  get "/random_word/:length" do
    custom_length = params[:length].to_i
    if custom_length > 20
      return "Length cannot be greater than 20 characters"
    end
    word = Lexicon.first.get_word custom_length
    [word].to_json
  end

end
