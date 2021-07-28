class City
  attr_reader :city, :arrivals, :departures, :id

  def initialize(attributes)
    attributes.each {|kvp| instance_variable_set("@#{kvp[0].to_s}", kvp[1].to_s.gsub("'"){"&#39;"})}
    # binding.pry
  end

  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("city")
      id = city.fetch("id").to_i
      cities.push(City.new({ :city => name, :id => id}))
    end
    cities
  end

  def save
    result = DB.exec("INSERT INTO cities (city) VALUES ('#{@city}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(comparison)
    self.city() == comparison.city()
  end

  def self.clear
    DB.exec("DELETE FROM cities *;")
  end

  def self.find(id)
    city = DB.exec("SELECT * FROM cities WHERE id = #{id};").first
    if city
      name= city.fetch("city")
      id = city.fetch("id").to_i
      City.new({ :city => name, :id => id})
    else
      false
    end
  end

  def update(name)
    @city = name
    DB.exec("UPDATE cities SET city = '#{@city}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM cities WHERE id = #{@id};")
    DB.exec("DELETE FROM stops WHERE city_id = #{@id};")
  end

  def trains
    Train.find_by_city(self.id)
  end

end