require 'rails_helper'

RSpec.describe Invoice, type: :model do
  let(:invoice) { Invoice.create!(status: 'shipped') }


  it 'initially has no transactions' do
    expect(invoice.transactions).to eq([])
  end

  it 'has munltiple transactions' do
    2.times do |x|
      invoice.transactions.create(credit_card_number: "123412341234#{x}")
    end
    expect(invoice.transactions.size).to eq(2)
  end
end
