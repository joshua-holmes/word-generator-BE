class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!",
      new_message: "Thanks" }.to_json
  end

  get "/stats" do
    pp Dir.entries("./python")
    file = File.read("./python/wordStats.json")
    file
  end

end
