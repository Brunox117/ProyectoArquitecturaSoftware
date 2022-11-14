# WebServer.rb
#run with -> ruby -I . -w WebServer.rb
require 'sinatra'
require 'faraday'
require 'json'
URLpreguntas = 'https://cyxpvpvfbqyudf6ub33ejitqfy0rnwcy.lambda-url.us-east-1.on.aws/preguntas'
enable :sessions
get '/' do
  session[:cantidadPreguntas] = 5
  @cantidadPreguntas = session[:cantidadPreguntas]
  erb :index
end

get '/preguntas/:n' do
  @cantidadPreguntas = params['n'].to_i || 5
  response = Faraday.get(URLpreguntas)
  @info = []
  if response.success?
    @info = JSON.parse(response.body)
  end
  @preguntas = []
  @preguntas = @info.sample(@cantidadPreguntas)
  @n = 0
  erb :preguntas
end
