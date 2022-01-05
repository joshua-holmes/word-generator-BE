class LexiconsController < ApplicationController
    get '/lexicons' do
        Lexicon.all.to_json
    end

    get "/lexicons/:lexicon_id" do
        lexicon = Lexicon.find(params[:lexicon_id])
        lexicon.to_json(include: :fake_words)
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
            saved_word = Word.find_by(word: word) || Word.create(word: word)
            LexiconWord.create(lexicon_id: lex.id, word_id: saved_word.id)
        end
        lex.to_json
    end

    post "/lexicons/:lexicon_id" do
        lexicon, word = Lexicon.find(params[:lexicon_id]), params[:word]
        if !lexicon
            return { message: "lexicon id in POST path was invalid" }.to_json
        elsif !word
            return { message: "A 'word' param must be included in body" }.to_json
        elsif lexicon.fake_words.find_by(word: word)
            return { message: "'#{word}' is already a favorite in lexicon '#{lexicon.name}'" }.to_json
        end
        fake_word = FakeWord.find_by(word: word) || FakeWord.create(word: word)
        FavoriteWord.create(lexicon_id: lexicon.id, fake_word_id: fake_word.id)
        fake_word.to_json
    end

    delete "/lexicons/:lexicon_id/:fake_word_id" do
        lexicon = Lexicon.find(params[:lexicon_id])
        fake_word = FakeWord.find(params[:fake_word_id])
        if !(lexicon && fake_word)
            return { message: "One or both id params in DELETE path are not related to a record" }.to_json
        end
        favorite_word = lexicon.favorite_words.find_by(fake_word_id: fake_word.id)
        if !favorite_word
            return { message: "Word referenced is not related to lexicon referenced" }.to_json
        end
        favorite_word.destroy
        fake_word.destroy if fake_word.lexicons.count == 0
        fake_word.to_json
    end
    
end
