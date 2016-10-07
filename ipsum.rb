require 'sinatra'

get '/' do
 	erb :index
end

get '/style.css' do 
	scss :style
end