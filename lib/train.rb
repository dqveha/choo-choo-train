class Train
  attr_reader :train, :arrivals, :departures, :id

  def initialize(attributes)
    attributes.each { |kvp| instance_variable_set("@#{kvp[0].to_s}", kvp[1].to_s.gsub("'") { "&#39;" }) }
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("train")
      id = train.fetch("id").to_i
      trains.push(Train.new({ :train => name, :id => id }))
    end
    trains
  end

  def save
    result = DB.exec("INSERT INTO trains (train) VALUES ('#{@train}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(comparison)
    if comparison != nil
      self.train == comparison.train
    else
      false
    end
  end

  def self.clear
    DB.exec("DELETE FROM trains *;")
  end

  def self.find(id)
    train = DB.exec("SELECT * FROM trains WHERE id = #{id};").first
    if train
      name = train.fetch("train")
      id = train.fetch("id").to_i
      Train.new({ :train => name, :id => id })
    else
      false
    end
  end

  def update(name)
    @train = name
    DB.exec("UPDATE trains SET train = '#{@train}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
    DB.exec("DELETE FROM stops WHERE train_id = #{@id};")
  end

  def self.find_by_city(city_id)
    trains = []
    returned_trains = DB.exec("SELECT * FROM trains WHERE city_id = #{city_id};")
    returned_trains.each() do |train|
      name = train.fetch("train")
      id = train.fetch("id").to_i
      trains.push(Train.new({ :train => name, :city_id => city_id, :id => id }))
    end
    trains
  end

  def self.find_by_stop(train_id)
    cities = []
    returned_cities = DB.exec("SELECT * FROM stops WHERE train_id = #{train_id};")
    returned_cities.each() do |city|
      city_id = city.fetch("city_id").to_i
      train_id = city.fetch("train_id").to_i
      arrival = city.fetch("arrival")
      departure = city.fetch("departure")
      id = city.fetch("id").to_i
      cities.push(Stop.new({ :id => id, :city_id => city_id, :train_id => train_id, :arrival => arrival, :departure => departure }))
    end
    cities
  end

  def cities
    City.find_by_train(self.id)
  end
end
