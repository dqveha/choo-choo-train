require "sinatra"
require "sinatra/reloader"
also_reload "lib/**/*.rb"
require "pry"
require "pg"
require "./lib/city"
require "./lib/train"
require "./lib/stop"

DB = PG.connect({ dbname: "train_system", user: "whain", password: "epicodus" })

get ("/") do
  @cities = City.all
  @trains = Train.all
  @stops = Stop.all
  erb(:index)
end

get ("/sort/stop") do
  @cities = City.all
  @trains = Train.all
  @stops = Stop.all
  erb(:index)
end

get ("/sort/train") do
  @cities = City.all
  @trains = Train.all
  @stops = Stop.sort_train
  erb(:index)
end

get ("/sort/arrival") do
  @cities = City.all
  @trains = Train.all
  @stops = Stop.sort_arrival
  erb(:index)
end

get ("/sort/departure") do
  @cities = City.all
  @trains = Train.all
  @stops = Stop.sort_departure
  erb(:index)
end

get ("/mgmt") do
  @trains = Train.all
  @cities = City.all
  @stops = Stop.all
  erb(:mgmt)
end

get ("/cities/:id") do
  city = City.find(params[:id].to_i)
  @city = City.find_by_stop(params[:id].to_i)
  @stops = Stop.all
  erb(:city)
end

get ("/trains/:id") do
  train = Train.find(params[:id].to_i)
  @train = Train.find_by_stop(params[:id].to_i)
  @stops = Stop.all
  erb(:train)
  #see the cities the train stops at
  #As a train rider, I want to view a train, so that I can see the cities where it stops.
end

get ("/trains/:id/cities/:city_id") do
  @city = City.find(params[:city_id].to_i())
  erb(:cities)
  #see all trains that passes through the city
end

get ("/trains/:id/edit") do
  #edit form to train to update or delete
end

post ("/mgmt/city") do
  @city = City.new({ :city => params[:city_name] })
  @city.save()
  redirect to("/mgmt")
end

post ("/mgmt/train") do
  @train = Train.new({ :train => params[:train_name] })
  @train.save()
  redirect to("/mgmt")
end

post ("/mgmt/add-stop") do
  city_id = params[:city_selection]
  train_id = params[:train_selection]
  arrival = ("%02d" % params[:a_h].to_s) + ":" + ("%02d" % params[:a_m].to_s)
  departure = ("%02d" % params[:d_h.to_s]) + ":" + ("%02d" % params[:d_m].to_s)
  @stop = Stop.new({ :city_id => city_id, :train_id => train_id, :arrival => arrival, :departure => departure })
  @stop.save
  redirect to("/mgmt")
end

get ("/stops") do
  @stops = Stop.all
  erb(:stops_table)
end

get ("/cities") do
  @cities = City.all
  erb(:cities)
end

get ("/trains") do
  @trains = Train.all
  erb(:trains)
end

# get ("/mgmt/stops/:id") do
#   @stop = Stop.find(params[:id].to_i)
#   @trains = Train.all
#   @cities = City.all
#   erb(:stop_update)
# end

delete ("/mgmt/delete/train") do
  @train = Train.find(params[:train_selection].to_i)
  @train.delete()
  redirect to("/mgmt")
end

delete ("/mgmt/delete/city") do
  @city = City.find(params[:city_selection].to_i)
  @city.delete()
  redirect to("/mgmt")
end

delete ("/mgmt/delete/stop") do
  @stop = Stop.find(params[:stop_selection].to_i)
  @stop.delete()
  redirect to("/mgmt")
end

get ("/mgmt/edit/stop/:id") do
  @stop = Stop.find(params[:id])
  @trains = Train.all
  @cities = City.all
  erb(:update_stop)
end

patch ("/mgmt/edit/stop/:id/city") do
  @stop = Stop.find(params[:id].to_i)
  @stop.update(params)
  redirect to("/mgmt")
end

patch ("/mgmt/edit/stop/:id/train") do
  @stop = Stop.find(params[:id].to_i)
  @stop.update(params)
  redirect to("/mgmt")
end

patch ("/mgmt/edit/stop/:id/arrival") do
  @stop = Stop.find(params[:id].to_i)
  @stop.update(params)
  redirect to("/mgmt")
end

patch ("/mgmt/edit/stop/:id/departure") do
  @stop = Stop.find(params[:id].to_i)
  @stop.update(params)
  redirect to("/mgmt")
end
