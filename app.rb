require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require 'pry'
require "pg"
require './lib/city'
require './lib/train'

DB = PG.connect({ dbname: 'train_system', host: 'db', user: 'postgres', password: 'password' })

get ('/') do
  @cities = City.all
  @trains = Train.all
  erb(:index)
end

get ('/mgmt') do
  @trains = Train.all
  @cities = City.all
  erb(:mgmt)
end

get ('/trains/:id') do
  @train = Train.find(params[:id].to_i())
  erb(:train)
  #see the cities the train stops at
  #As a train rider, I want to view a train, so that I can see the cities where it stops.
end

get ('/trains/:id/cities/:city_id') do
  @city = City.find(params[:city_id].to_i())
  erb(:city)
  #see all trains that passes through the city
end

get ('/trains/:id/edit') do
  #edit form to train to update or delete
end

post ('/mgmt/city') do
  
  erb(:mgmt)
end

post ('/mgmt/train') do
  
  erb(:mgmt)
end
