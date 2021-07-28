require 'rspec'
require 'city'
require 'train'
require 'pry'
require 'spec_helper'

describe '#Train' do

  before(:each) do
    @train =  Train.new({:train => "Jumbo", :id => nil})
    @train.save()
    @train2 =  Train.new({:train => "Tank", :id => nil})
    @train2.save()
  end

  describe('.all') do
    it("returns an empty array when there are no trains") do
      Train.clear
      expect( Train.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an train") do
      expect( Train.all).to(eq([@train, @train2]))
    end
  end

  describe('.clear') do
    it("clears all trains") do
      Train.clear
      expect( Train.all).to(eq([]))
    end
  end

  describe('#==') do
    it("is the same train if it has the same attributes as another train") do
      train3 =  Train.new({:train => "Jumbo", :id => nil})
      train3.save()
      expect(@train).to(eq(train3))
    end
  end

  describe('.find') do
    it("finds an train by id") do
      expect( Train.find(@train.id)).to(eq(@train))
    end
  end

  describe('#update') do
    it("updates an train by id") do
      @train.update("Tank")
      expect(@train.train).to(eq("Tank"))
    end
  end

  describe('#delete') do
    it("deletes an train by id") do
      @train.delete()
      expect(Train.all).to(eq([@train2]))
    end
  end

  #   it("deletes all cities belonging to a deleted train") do
  #     city = City.new({:city => "Naima", :train_id => @train.id, :id => nil})
  #     city.save()
  #     @train.delete()
  #     expect(City.find(city.id)).to(eq(nil))
  #   end
  # end

  # describe('#cities') do
  #   it("returns the cities that trains goes through") do
  #     city = City.new({:city => "Portland", :train_id => @train.id, :id => nil})
  #     city.save()
  #     city2 = City.new({:city => "Seattle", :train_id => @train.id, :id => nil})
  #     city2.save()
  #     expect(@train.cities).to(eq([city, city2]))
  #   end
  # end
end