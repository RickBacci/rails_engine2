class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  def revenue
    invoices.successful.joins(:invoice_items).sum("unit_price * quantity")
  end

  def successful_invoices
    invoices.where { |invoice| invoice.transactions.select { |transaction| transaction.result == 'success' }}.flatten
  end
end
