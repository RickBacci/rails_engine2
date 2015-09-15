require 'csv'

namespace :parser do

  desc "Parse csv data into the database"

  task parse: :environment do


    models = { customers:     Customer,
               merchants:     Merchant,
               items:         Item,
               invoices:      Invoice,
               transactions:  Transaction,
               invoice_items: InvoiceItem }

    models.each do |file, model|
      start_time = Time.now

      file = "lib/assets/#{file}.csv"

      CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
        model.create(row.to_hash)
      end

      puts "#{model.all.size} #{model} records imported successfully"
    end
    puts "Data parsed in #{Time.now - start_time} seconds."
  end
end

