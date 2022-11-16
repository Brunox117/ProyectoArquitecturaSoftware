# Final Project: Quiz Application with Microservices
# Date: 28-Nov-2022
# Authors:
#          A01748931 Bruno Omar Jimenez Mancilla
#          A01748559 Roberto Castro Barrios
# File name: WebServer.rb
#The source code in this file uses sinatra to serve as a web server and also uses faraday to receive information
#from a Dynamodb, also uses sessions to pass certain data between routes. 
require 'sinatra'
require 'faraday'
require 'json'
URLpreguntas = 'https://cyxpvpvfbqyudf6ub33ejitqfy0rnwcy.lambda-url.us-east-1.on.aws/preguntas'
enable :sessions
#This method is used as the main page of the web
get '/' do
  session[:cantidadPreguntas] = 5
  @cantidadPreguntas = session[:cantidadPreguntas]
  erb :index
end
#This method is used for the route preguntas and receives a number, it´s called from the index file.
#This methos uses faraday to obtain all the questions stored in a dynamodb an then selects a n number of them
#to create the quizz
get '/preguntas/:n' do
  @cantidadPreguntas = params['n'].to_i || 5
  response = Faraday.get(URLpreguntas)
  @info = []
  if response.success?
    @info = JSON.parse(response.body)
  end
  @preguntas = []
  @preguntas = @info.sample(@cantidadPreguntas)
  session[:listaPreguntas] = @preguntas
  session[:cantidadPreguntas] = @cantidadPreguntas
  @n = 0
  erb :preguntas
end
#This method is used to display the results of the quiz, it converts all the answers of the user, that received as a param
#to an array 
get '/respuestas/:response' do
    @resp = params['response']
    @resp.to_s
    @resp = @resp.split(',')
    @preguntas = session[:listaPreguntas]
    @cantidadPreguntas = session[:cantidadPreguntas]
    @n = 0
    erb :respuestas
end
