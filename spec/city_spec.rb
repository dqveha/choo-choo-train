require 'rspec'
require 'city'
require 'train'
require 'pry'
require 'spec_helper'

describe '#City' do

  before(:each) do
    @city =  City.new({:city => "Portland"})
    @city.save()
    @city2 =  City.new({:city => "Seattle"})
    @city2.save()
  end

  describe('.all') do
    it("returns an empty array when there are no cities") do
      City.clear
      expect( City.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an city") do
      expect( City.all).to(eq([@city, @city2]))
    end
  end

  describe('.clear') do
    it("clears all cities") do
      City.clear
      expect( City.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same city if it has the same attributes as another city") do
      city3 =  City.new({:city => "Portland"})
      city3.save()
      expect(@city).to(eq(city3))
    end
  end

  describe('.find') do
    it("finds a city by id") do
      expect( City.find(@city.id)).to(eq(@city))
    end
  end

  describe('#update') do
    it("updates a city by id") do
      @city.update("San Jose")
      expect(@city.city).to(eq("San Jose"))
    end
  end

  describe('#delete') do
    it("deletes a city by id") do
      @city.delete()
      expect( City.all).to(eq([@city2]))
    end
  end

  #   it("deletes all trains belonging to a deleted city") do
  #     train = Train.new({:train => "Slowtown Express"})
  #     train.save()
  #     @city.delete()
  #     expect(Train.find(train.id)).to(eq(nil))
  #   end
  # end

  # describe('#trains') do
  #   it("returns a city's trains") do
  #     train = Train.new({:train => "Fastway", :city_id => @city.id})
  #     train.save()
  #     train2 = Train.new({:train => "Stuck behind everything", :city_id => @city.id})
  #     train2.save()
  #     expect(@city.trains).to(eq([train, train2]))
  #   end
  # end
end