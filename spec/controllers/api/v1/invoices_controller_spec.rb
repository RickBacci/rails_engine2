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
end
