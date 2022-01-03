class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    "Welcome!!
    /random_word/example will generate a random word between 3 and 9 (inclusive) characters long
    /random_word/example/7 will generate a random word 7 characters long
    /random_word/example/5 will generate a random word 5 characters long
    /random_word/example/0 will generate a random word that ends when letter combinations can no longer be found in the dictionary (not recommended)
    20 characters is the maximum acceptable word length"
  end

  get "/random_word/:name" do
    name = params[:name]
    word = Lexicon.find_by(name: name).get_word
    [word].to_json
  end

  get "/random_word/:name/:length" do
    name = params[:name]
    custom_length = params[:length].to_i
    if custom_length > 20
      return "Length cannot be greater than 20 characters"
    end
    word = Lexicon.find_by(name: name).get_word custom_length
    [word].to_json
  end

  post "/create_lexicon" do
    name, words = params[:name], params[:words]
    lex = Lexicon.create(name: name)
    words.each do |word|
      if Word.find_by(word: word)
        saved_word = Word.find_by(word: word)
      else
        saved_word = Word.create(word: word)
      end
      LexiconWord.create(lexicon_id: lex.id, word_id: saved_word.id)
    end
    {name: name, words: words}.to_json
  end

end
