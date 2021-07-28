require 'rspec'
require 'pg'
require 'pry'

DB = PG.connect({ dbname: 'train_system_test', host: 'db', user: 'postgres', password: 'password' })

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM cities *;")
    # Add code to clear database.
  end
end
