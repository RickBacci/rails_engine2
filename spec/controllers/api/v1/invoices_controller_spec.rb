require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do

  describe "#all" do

    it "returns all invoices" do
      2.times do |x|
        Invoice.create(status: "shipped#{x}")
      end

      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#random" do

    it "returns a random invoice" do
      20.times do |x|
        Invoice.create(status: "shipped#{x}")
      end

      duplicate_invoices = 0

      40.times do
        get :random, format: :json
        m1 = (JSON.parse(response.body)['status'])
        get :random, format: :json
        m2 = (JSON.parse(response.body)['status'])

        duplicate_invoices += 1 if m1 == m2
      end

      expect(response).to have_http_status(:success)
      expect(duplicate_invoices).to be < 10
    end
  end

  describe "#show" do
    it "returns a invoice" do
      invoice = Invoice.create!(status: 'shipped')

      get :show, id: invoice.id, format: :json

      expect(JSON.parse(response.body)['status']).to eq('shipped')
      expect(response).to have_http_status(:success)
    end
  end

  describe "#find" do
    it "finds a single invoice that matches a query param" do
      invoice = Invoice.create!(status: 'shipped')

      get :find,  id: invoice.id, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['status']).to eq('shipped')
    end
  end

  describe "#find_all" do
    it "returns all invoices with the same attribute" do

      Invoice.create(status: "shipped")
      Invoice.create(status: "shipped")
      Invoice.create(status: "!shipped")

      get :find_all, status: 'shipped', format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#transactions" do
    it "returns all transactions for an invoice" do
      invoice = Invoice.create!(status: 'shipped')

      2.times do |x|
        invoice.transactions.create(credit_card_number: "12341234#{x}")
      end

      get :transactions, id: invoice.id, format: :json

      expect(response).to have_http_status(:success)
      expect(invoice.transactions.size).to eq(2)
    end
  end

  describe "#invoice_items" do
    it 'returns all invoice_items for an invoice' do
      invoice = Invoice.create!(status: 'shipped')

      2.times do |x|
        invoice.invoice_items.create(quantity: "#{x}", unit_price: "1.00")
      end

      get :invoice_items, id: invoice.id, format: :json

      expect(response).to have_http_status(:success)
      expect(invoice.invoice_items.size).to eq(2)
    end
  end

  describe "#items" do
    it 'returns all items for an invoice' do
      invoice = Invoice.create!(status: 'shipped')

      2.times do |x|
        invoice.items.create(name: "item#{x}", description: "item description#{x}")
      end

      get :items, id: invoice.id, format: :json

      expect(response).to have_http_status(:success)
      expect(invoice.items.size).to eq(2)
    end
  end

  describe "#customer" do
    it 'returns customer for an invoice' do
      customer = Customer.create!(first_name: 'joe')
      invoice = Invoice.create!(status: 'shipped', customer_id: customer.id)

      get :customer, id: invoice.id, format: :json

      expect(response).to have_http_status(:success)

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(customer[:first_name]).to eq('joe')
    end
  end

  describe "#merchant" do
    it 'returns merchant for an invoice' do
      merchant = Merchant.create!(name: 'acme')
      invoice = Invoice.create!(status: 'shipped', merchant_id: merchant.id)

      get :merchant, id: invoice.id, format: :json

      expect(response).to have_http_status(:success)

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant[:name]).to eq('acme')
    end
  end
end
