class LexiconsController < ApplicationController
    get '/lexicons' do
        Lexicon.all.to_json
    end

    get "/lexicons/:lexicon_id" do
        lexicon = Lexicon.find(params[:lexicon_id])
        lexicon.to_json(include: :favorite_words)
    end

    post '/lexicons' do
        name, words = params[:name], params[:words]
        if !(name && words)
            return { message: "Either 'name' or 'words' param was empty in body" }.to_json
        elsif Lexicon.find_by(name: name)
            return { 
                message: "The name '#{name}' is already in use and is invalid." 
            }.to_json 
        end
        lex = Lexicon.create(name: name)
        words.each do |word|
            saved_word = Word.find_by(word: word.downcase) || Word.create(word: word.downcase)
            LexiconWord.create(lexicon_id: lex.id, word_id: saved_word.id)
        end
        lex.to_json
    end

    post "/lexicons/:lexicon_id" do
        lexicon, word = Lexicon.find(params[:lexicon_id]), params[:word].downcase
        if !word
            return { message: "A 'word' param must be included in body" }.to_json
        elsif lexicon.favorite_words.find_by(word: word)
            return { message: "'#{word}' is already a favorite in lexicon '#{lexicon.name}'" }.to_json
        end
        fave_word = FavoriteWord.create(lexicon_id: lexicon.id, word: word)
        fave_word.to_json
    end

    delete "/lexicons/:lexicon_id/:favorite_word_id" do
        lexicon = Lexicon.find(params[:lexicon_id])
        favorite_word = lexicon.favorite_words.find(params[:favorite_word_id])
        favorite_word.destroy
        favorite_word.to_json
    end
    
end
