# Final Project: Quiz Application with Microservices
# Date: 28-Nov-2022
# Authors:
#          A01748931 Bruno Omar Jimenez Mancilla 
#          Roberto Castro Barrios A01748559
# File name: WebServer.rb
require 'sinatra'
require 'faraday'
require 'json'
#The source code in this file uses sinatra to serve as a web server that connects all the views of the project
URLpreguntas = 'https://cyxpvpvfbqyudf6ub33ejitqfy0rnwcy.lambda-url.us-east-1.on.aws/preguntas'
enable :sessions
#This method serve is the main route of the web
get '/' do
  session[:cantidadPreguntas] = 5
  @cantidadPreguntas = session[:cantidadPreguntas]
  erb :index
end
#This route is called in the index file it uses faraday to obtain the questions of a dynamodb using faraday
#and uses the functon parse to select n random questions of the dynamodb json that received. 'n' is given to 
#the route using params
get '/preguntas/:n' do
  @cantidadPreguntas = params['n'].to_i || 5
  response = Faraday.get(URLpreguntas)
  @info = []
  if response.success?
    @info = JSON.parse(response.body)
  end
  @preguntas = []
  @preguntas = @info.sample(@cantidadPreguntas)
  erb :preguntas
end
