require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do

  let(:invoice) { Invoice.create!(status: 'shipped') }

  describe "#all" do

    it "returns all invoice_items" do

      2.times do |x|
        invoice.invoice_items.create!(quantity: "#{x}", unit_price: "2.00")
      end

      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#random" do

    it "returns a random invoice_item" do
      20.times do |x|
        price = rand(1..9)
        invoice.invoice_items.create!(quantity: "#{x}", unit_price: "#{price}.00")
      end

      duplicate_invoice_items = 0

      40.times do
        get :random, format: :json
        m1 = (JSON.parse(response.body)['quantity'])
        get :random, format: :json
        m2 = (JSON.parse(response.body)['quantity'])

        duplicate_invoice_items += 1 if m1 == m2
      end

      expect(response).to have_http_status(:success)
      expect(duplicate_invoice_items).to be < 10
    end
  end

  describe "#show" do
    it "returns an invoice_item" do
      2.times do |x|
        invoice.invoice_items.create!(quantity: "#{x}", unit_price: "2.00")
      end

      get :show, id: InvoiceItem.first.id, format: :json

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item[:quantity]).to eq(0)
    end
  end

  describe "#find" do
    it "finds a single invoice_item that matches a query param" do

      2.times do |x|
        invoice.invoice_items.create!(quantity: "#{x}", unit_price: "2.00")
      end

      get :find, id: InvoiceItem.first.id, format: :json

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_item[:id]).to eq(InvoiceItem.first.id)
    end
  end

  describe "#find_all" do
    it "returns all invoice_items with the same attribute" do
      2.times do |x|
        invoice.invoice_items.create!(quantity: "#{x}", unit_price: "2.00")
      end

      get :find_all, unit_price: '2.00', format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end


end
