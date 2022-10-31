# WebServer.rb
#run with -> ruby -I . -w WebServer.rb
require 'sinatra'

get '/' do
  erb :index
end

get '/preguntas' do
  'Aqui van las preguntas'
end
