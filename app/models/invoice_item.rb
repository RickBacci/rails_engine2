class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item

  def subtotal
    unit_price * quantity
  end
end
