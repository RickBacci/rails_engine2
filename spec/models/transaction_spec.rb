require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let(:invoice) { Invoice.create!(status: 'shipped') }


  it 'has an invoice' do
    transaction = invoice.transactions.create!(result: "success")

    expect(transaction.invoice.id).to eq(invoice.id)
  end
end
