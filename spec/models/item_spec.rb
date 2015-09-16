require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:merchant) { Merchant.create!(name: 'acme') }
  let(:item) { merchant.items.create!(name: 'item1') }

  it 'initially has no invoice_items' do
    expect(item.invoice_items).to eq([])
  end

  it 'has multiple invoice_items' do
    2.times do |x|
      item.invoice_items.create(quantity: "#{x}", unit_price: "1.00")
    end

    expect(item.invoice_items.size).to eq(2)
  end

  it 'has a merchant' do
    expect(item.merchant.name).to eq('acme')
  end
end
