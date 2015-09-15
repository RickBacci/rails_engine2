class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.decimal :unit_price
      t.datetime :created_at
      t.datetime :updated_at
      t.references :invoice, index: true, foreign_key: true
      t.references :item, index: true, foreign_key: true
    end
  end
end
