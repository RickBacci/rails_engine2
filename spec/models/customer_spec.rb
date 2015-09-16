require 'rails_helper'

RSpec.describe Customer, type: :model do
  let(:customer) { Customer.create!(first_name: 'customer1') }

  context 'can have a collection of invoices' do

    it 'that starts out empty' do
      expect(customer.invoices).to eq([])
    end

    it 'that can be added to' do
      customer.invoices.create!(status: 'successful')
      customer.invoices.create!(status: 'successful')

      expect(customer.invoices.size).to eq(2)
    end
  end

  context 'can have a collection of transactions' do

    it 'that starts out empty' do
      expect(customer.transactions).to eq([])
    end

    it 'that can be added to' do
      customer.invoices.create!(status: "success")
      invoice = customer.invoices.first

      2.times do
        invoice.transactions.create!(result: "success")
      end

      expect(customer.transactions.size).to eq(2)
    end
  end
end
