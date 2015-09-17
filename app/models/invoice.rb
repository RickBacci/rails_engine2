class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant

  has_many :transactions

  has_many :invoice_items
  has_many :items, through: :invoice_items

  def self.successful
    joins(:transactions).where("result = 'success'")
  end

  def self.revenue_by_date(date)
    successful.where(created_at: date)
  end

  def self.pending
    joins(:transactions).where("result = 'failed'")
  end
end
