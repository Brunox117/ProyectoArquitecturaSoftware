# WebServer.rb
#run with -> ruby -I . -w WebServer.rb
require 'sinatra'

get '/' do
  @cantidadPreguntas = 5
  erb :index
end

get '/preguntas' do
  "Aqui irian {#@cantidadPreguntas} preguntas"
end
