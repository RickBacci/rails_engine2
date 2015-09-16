require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:customer) { Customer.create(first_name: 'joe') }
  let(:merchant) { Merchant.create(name: 'acme') }

  let(:invoice) { Invoice.create!(status: 'shipped',
                                  customer_id: customer.id,
                                  merchant_id: merchant.id) }

  it 'initially has no transactions' do
    expect(invoice.transactions).to eq([])
  end

  it 'has multiple transactions' do
    2.times do |x|
      invoice.transactions.create(credit_card_number: "123412341234#{x}")
    end

    expect(invoice.transactions.size).to eq(2)
  end

  it 'initially has no items' do
    expect(invoice.items).to eq([])
  end

  it 'has multiple items' do
    2.times do |x|
      invoice.items.create(name: "item#{x}")
    end

    expect(invoice.items.size).to eq(2)
  end


  it 'has a customer' do
    expect(invoice.customer.first_name).to eq('joe')
  end

  it 'has a merchant' do
    expect(invoice.merchant.name).to eq('acme')
  end
end
