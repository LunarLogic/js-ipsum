require 'sinatra'
require 'marky_markov'

get '/' do
	markov = MarkyMarkov::TemporaryDictionary.new
	markov.parse_file "file.txt"
	@generated = markov.generate_n_sentences 5
 	erb :index
end

get '/style.css' do
	scss :"../stylesheets/style"
end