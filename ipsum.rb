require 'sinatra'
require 'marky_markov'

get '/' do
	@text_length =  params[:"text-length"]
	markov = MarkyMarkov::TemporaryDictionary.new
	markov.parse_file "jargon.txt"
	markov.parse_file "wiki.txt"
	if @text_length == "short" then
		@generated = markov.generate_n_sentences 1
	elsif @text_length == "medium" then
		@generated = markov.generate_n_sentences 5
	else 
		@generated = markov.generate_n_sentences 25
	end
 	erb :index
end

get '/style.css' do
	scss :"../stylesheets/style"
end