class LexiconsController < ApplicationController
    post '/lexicons' do
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
        { name: name, words: words }.to_json
    end

    get '/lexicons' do
        Lexicon.all.to_json
    end
end
