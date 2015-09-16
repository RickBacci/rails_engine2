require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  describe "#all" do

    it "returns all items" do
      2.times do |x|
        Item.create(name: "item#{x}", unit_price: "1.00")
      end

      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#random" do

    it "returns a random item" do
      20.times do |x|
        Item.create(name: "item#{x}")
      end

      duplicate_items = 0

      40.times do
        get :random, format: :json
        m1 = (JSON.parse(response.body)['name'])
        get :random, format: :json
        m2 = (JSON.parse(response.body)['name'])

        duplicate_items += 1 if m1 == m2
      end

      expect(response).to have_http_status(:success)
      expect(duplicate_items).to be < 10
    end
  end

  describe "#show" do
    it "returns a item" do
      item = Item.create!(name: 'item1')

      get :show, id: item.id, format: :json

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item[:name]).to eq('item1')
    end
  end

  describe "#find" do
    it "finds a single item that matches a query param" do
      item = Item.create!(name: 'item1')

      get :find, name: item.name, format: :json

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(item[:name]).to eq('item1')
    end
  end

  describe "#find_all" do
    it "returns all invoices with the same attribute" do
      Item.create!(name: 'item1')
      Item.create!(name: 'item1')
      Item.create!(name: 'item1')

      get :find_all, name: 'item1', format: :json

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(items.size).to eq(3)
    end
  end

  describe "#invoice_items" do
    it 'returns all invoice_items associated with this item' do
      item = Item.create!(name: 'item1')
      2.times do
        item.invoice_items.create!(quantity: 10, unit_price: "2.00")
      end

      get :invoice_items, id: item.id, format: :json

      invoice_items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(invoice_items.size).to eq(2)
    end
  end

  describe "#merchant" do
    it 'returns the merchant associated with this item' do
      merchant = Merchant.create!(name: 'acme')
      merchant.items.create!(name: 'item1')
      item = Item.last

      get :merchant, id: item.id, format: :json

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(merchant[:name]).to eq('acme')
    end
  end
end
