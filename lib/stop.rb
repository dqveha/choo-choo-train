class Stop
  attr_reader :id, :city_id, :train_id, :arrival, :departure

  def initialize(attributes)
    attributes.each { |kvp| instance_variable_set("@#{kvp[0].to_s}", kvp[1].to_s.gsub("'") { "&#39;" }) }
  end

  def self.all
    returned_stops = DB.exec("SELECT * FROM stops;")
    stops = []
    returned_stops.each() do |stop|
      city_id = stop.fetch("city_id").to_i
      train_id = stop.fetch("train_id").to_i
      arrival = stop.fetch("arrival")
      departure = stop.fetch("departure")
      id = stop.fetch("id").to_i
      stops.push(Stop.new({ :id => id, :city_id => city_id, :train_id => train_id, :arrival => arrival, :departure => departure }))
    end
    stops
  end

  def save
    result = DB.exec("INSERT INTO stops (city_id, train_id, arrival, departure) VALUES (#{city_id}, #{train_id}, '#{arrival}', '#{departure}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(comparison)
    self.stop() == comparison.stop()
  end

  def self.clear
    DB.exec("DELETE FROM stops *;")
  end

  def self.find(id)
    stop = DB.exec("SELECT * FROM stops WHERE id = #{id};").first
    if stop
      city_id = stop.fetch("city_id").to_i
      train_id = stop.fetch("train_id").to_i
      arrival = stop.fetch("arrival")
      departure = stop.fetch("departure")
      id = stop.fetch("id").to_i
      Stop.new({ :id => id, :city_id => city_id, :train_id => train_id, :arrival => arrival, :departure => departure })
    else
      false
    end
  end

  def update(attributes)
    column = ""
    value = ""
    if attributes.keys.include?("city_selection")
      column = "city_id"
      value = attributes.fetch("city_selection")
    elsif attributes.keys.include?("train_selection")
      column = "train_id"
      value = attributes.fetch("train_selection")
    elsif attributes.keys.include?("a_h")
      value = ("%02d" % attributes.fetch("a_h").to_s) + ":" + ("%02d" % attributes.fetch("a_m").to_s)
      column = "arrival"
    elsif attributes.keys.include?("d_h")
      value = ("%02d" % attributes.fetch("d_h").to_s) + ":" + ("%02d" % attributes.fetch("d_m").to_s)
      column = "departure"
    else
      puts "error"
    end
    DB.exec("UPDATE stops SET #{column} = '#{value}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM stops WHERE id = #{@id};")
  end

  def self.find_by_train(train_id)
    stops = []
    returned_stops = DB.exec("SELECT * FROM stops WHERE train_id = #{train_id};")
    returned_stops.each() do |stop|
      name = stop.fetch("stop")
      id = stop.fetch("id").to_i
      stops.push(stop.new({ :stop => name, :train_id => stop_id, :id => id }))
    end
    trains
  end

  def trains
    Train.find_by_stop(self.id)
  end
end
