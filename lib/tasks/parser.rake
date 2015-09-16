require 'csv'
require 'bigdecimal'

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
        if model == models[:items] || model == models[:invoice_items]
          decimal = BigDecimal.new(row[:unit_price].insert(-3, '.'))
          row['unit_price'] = decimal
        end

        model.create!(row.to_h.except('credit_card_expiration_date'))
      end

      puts "#{model.all.size} #{model} records imported successfully"\
           " in #{Time.now - start_time} seconds."
    end
  end
end

