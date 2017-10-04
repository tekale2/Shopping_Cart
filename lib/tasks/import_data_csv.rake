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

  task :create_payments =>  :environment do
    CSV.foreach(File.expand_path("data/Payment.csv"), :headers=>true, converters: :date) do |row|
      hashVal = row.to_hash
      hashVal["expiry"] = Date.strptime(hashVal["expiry"], "%m/%d/%Y")
      Payment.create!(hashVal)
    end
  end

  task :create_orders =>  :environment do
    CSV.foreach(File.expand_path("data/Order.csv"), :headers=>true, converters: :date) do |row|
      hashVal = row.to_hash
      hashVal["placedOn"] = Date.strptime(hashVal["placedOn"], "%m/%d/%Y")
      Order.create!(hashVal)
    end
  end

  task :create_customer_addresses =>  :environment do
    CSV.foreach(File.expand_path("data/Customer_Address.csv"), :headers=>true) do |row|
      hashVal = row.to_hash
      CustomerAddress.create!(hashVal)
    end
  end

  task :create_order_items =>  :environment do
    CSV.foreach(File.expand_path("data/OrderItem.csv"), :headers=>true) do |row|
      hashVal = row.to_hash
      OrderItem.create!(hashVal)
    end
  end


  task :create_items =>  :environment do
    items_list = JSON.parse(File.read("data/Item.json"))
    items_list.each do |row|
      Item.create!(row.to_hash)
    end
  end
 end