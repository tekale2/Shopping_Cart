require 'csv'
require 'json'
namespace :import_data_csv do
  task :create_customers =>  :environment do
    CSV.foreach(File.expand_path("data/Customer.csv"), :headers=>true) do |row|
      Customer.create!(row.to_hash)
    end
  end

  task :create_addresses =>  :environment do
    CSV.foreach(File.expand_path("data/Address.csv"), :headers=>true) do |row|
      Address.create!(row.to_hash)
    end
  end

  task :create_items =>  :environment do
    items_list = JSON.parse(File.read("data/Item.json"))
    items_list.each do |row|
      Item.create!(row.to_hash)
    end
  end
 end