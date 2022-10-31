# WebServer.rb
#run with ruby WebServer.rb
require 'sinatra'

get '/' do
  send_file 'index.html'
end
