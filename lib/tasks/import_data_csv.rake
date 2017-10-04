require 'csv'
namespace :import_data_csv do
  task :create_customers =>  :environment do
    CSV.foreach(File.expand_path("data/Customer.csv"), :headers=>true) do |row|
      Customer.create!(row.to_hash)
    end
  end
 end