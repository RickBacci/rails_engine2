class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices


  def revenue(date='')
    if date == ''
      invoices.successful.joins(:invoice_items).sum("unit_price * quantity")
    else
      invoices.successful.where(created_at: date).joins(:invoice_items).sum("unit_price * quantity")
    end
  end

  def successful_invoices
    invoices.successful
  end

  def self.most_revenue(limit)
    all.sort { |merchant1, merchant2| merchant2.revenue <=> merchant1.revenue }.take(limit.to_i)
  end
end
