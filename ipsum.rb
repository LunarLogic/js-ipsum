require 'sinatra'
require 'marky_markov'
require 'pry' #testing purposes

get '/' do
  load_markov_dictionary
  @text_length =  params[:"text-length"]
  @text_length ||= "medium"

  if @text_length == "short" then
    @generated = @markov.generate_n_sentences 5
  elsif @text_length == "medium" then
    @generated = @markov.generate_n_sentences 15
  else 
    @generated = @markov.generate_n_sentences 10
    @generated += "\n\n"
    @generated += @markov.generate_n_sentences 10
    @generated += "\n\n"
    @generated += @markov.generate_n_sentences 10

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


def load_markov_dictionary
  @markov = MarkyMarkov::Dictionary.new('dictionary')
  unless File.exist?('dictionary.mmd')
    @markov.parse_file "jargon.txt"
    @markov.parse_file "wiki.txt"
    @markov.save_dictionary! # Saves the modified dictionary/creates one if it didn't exist.
  end
end