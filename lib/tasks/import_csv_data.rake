require 'smarter_csv'
require 'benchmark'
require './app/models/poros/integer_converter'

namespace :import_csv_data do
  desc 'import data from CSV files'
  task load: :environment do
    file_objects = {
      'db/data/customers.csv' => Customer,
      'db/data/merchants.csv' => Merchant,
      'db/data/items.csv' => Item,
      'db/data/invoices.csv' => Invoice,
      'db/data/invoice_items.csv' => InvoiceItem,
      'db/data/transactions.csv' => Transaction
    }

    puts 'Preparing to delete exisiting data'
    file_objects.values.each(&:destroy_all)
    puts 'Database is now reset'
    puts 'Loading new data'

    file_objects.each do |file, object|
      total_time = Benchmark.realtime do
        options = { value_converters: { unit_price: IntegerConverter }, headers: true }
        SmarterCSV.process(file, options) do |row|
          object.create!(row)
        end
      end
      puts "total time to import #{object}s: #{total_time} seconds"
    end

    puts 'import_csv_data rake task complete'

    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.reset_pk_sequence!(table)
    end
  end
end
