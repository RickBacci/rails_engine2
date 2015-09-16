require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  let(:item) { Item.create(name: 'item1', unit_price: '1.00') }
  let(:invoice) { Invoice.create!(status: 'shipped') }


  it 'has an invoice' do
    invoice_item = invoice.invoice_items.create!(quantity: "1", unit_price: "2.00")

    expect(invoice_item.invoice_id).to eq(invoice.id)
  end

  it 'has an item' do
    invoice_item = invoice.invoice_items.create!(quantity: "1", unit_price: "2.00", item_id: item.id)

    expect(invoice_item.item_id).to eq(item.id)
  end
end
