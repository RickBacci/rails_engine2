require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do

  describe "#all" do

    it "returns all merchants" do
      2.times do |x|
        Merchant.create(name: "merchant#{x}")
      end

      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#random" do

    it "returns a random merchant" do
      20.times do |x|
        Merchant.create(name: "merchant#{x}")
      end

      duplicate_merchants = 0

      40.times do
        get :random, format: :json
        m1 = (JSON.parse(response.body)['name'])
        get :random, format: :json
        m2 = (JSON.parse(response.body)['name'])

        duplicate_merchants += 1 if m1 == m2
      end

      expect(response).to have_http_status(:success)
      expect(duplicate_merchants).to be < 10
    end
  end

  describe "#show" do
    it "returns a merchant" do
      merchant = Merchant.create!(name: 'acme')

      get :show, id: merchant.id, format: :json

      expect(JSON.parse(response.body)['name']).to eq('acme')
      expect(response).to have_http_status(:success)
    end
  end

  describe "#find" do
    it "finds a single merchant that matches a query param" do
      merchant = Merchant.create!(name: 'acme2')

      get :find,  id: merchant.id, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['name']).to eq('acme2')
    end
  end

  describe "#find_all" do
    it "returns all merchants with the same attribute" do

      Merchant.create(name: "merchant1")
      Merchant.create(name: "merchant1")
      Merchant.create(name: "!merchant1")

      get :find_all, name: 'merchant1', format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#items" do

    it "returns all the merchants items" do

      Merchant.create(name: "merchant1")

      2.times do |x|
        Merchant.first.items.create(name: "name#{x}",description: "desc#{x}")
      end

      get :items, id: Merchant.first.id, format: :json

      expect(JSON.parse(response.body).size).to eq(2)
      expect(response).to have_http_status(:success)
    end
  end

  describe "#invoices" do
    let(:merchant) { Merchant.create!(name: 'acme') }

    it 'returns all of the merchants invoices' do
      2.times do |x|
        merchant.invoices << Invoice.new(status: 'shipped')
      end

      get :invoices, id: merchant.id, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#revenue" do
    let(:merchant) { Merchant.create!(name: 'acme') }

    it 'returns total revenue for merchant across all transactions' do
      2.times do |x|
        merchant.invoices.create!(status: 'pending')
      end

      Invoice.first.transactions.create!(credit_card_number: '1234123412341234', result: 'success')
      Invoice.last.transactions.create!(credit_card_number: '1234123412341234', result: 'failed')

      get :revenue, id: merchant.id, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end
end
