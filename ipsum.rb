require 'sinatra'
require 'marky_markov'
require 'pry' #testing purposes

get '/' do
  markov = MarkyMarkov::TemporaryDictionary.new
  markov.parse_file "jargon.txt"
  markov.parse_file "wiki.txt"
  @text_length =  params[:"text-length"]

  if @text_length == "short" then
    @generated = markov.generate_n_sentences 5
  elsif @text_length == "long" then
    @generated = markov.generate_n_sentences 10
    @generated += "\n\n"
    @generated += markov.generate_n_sentences 10
    @generated += "\n\n"
    @generated += markov.generate_n_sentences 10
  else 
    @generated = markov.generate_n_sentences 15
  end

  if request.xhr? then
    @generated 
  else 
    erb :index
  end
  
end

get '/style.css' do
  scss :"../stylesheets/style"
end
