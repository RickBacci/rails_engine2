class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  def revenue
    successful_invoices.invoice_items.reduce(0) { |sum, item| sum + item.subtotal }
  end

  def successful_invoices
    invoices.where { |invoice| invoice.transactions.select { |transaction| transaction.result == 'success' }}.flatten
  end
end
