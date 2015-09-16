require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do

  describe "#all" do
    it "returns all transactions" do
      2.times do |x|
        Transaction.create!(credit_card_number: "123412341234123#{x}", result: "success")
      end

      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "#random" do
    it "returns a random transaction" do
      20.times do |x|
        Transaction.create!(result: "success")
      end

      duplicate_transactions = 0

      40.times do
        get :random, format: :json
        m1 = (JSON.parse(response.body)['id'])
        get :random, format: :json
        m2 = (JSON.parse(response.body)['id'])

        duplicate_transactions += 1 if m1 == m2
      end

      expect(response).to have_http_status(:success)
      expect(duplicate_transactions).to be < 10
    end
  end

  describe "#show" do
    it "returns a transaction" do
      transaction = Transaction.create!(result: "success")

      get :show, id: transaction.id, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['result']).to eq('success')
    end
  end

  describe "#find" do
    it "finds a single transaction that matches a query param" do
      transaction = Transaction.create!(result: "success")

      get :find, id: transaction.id, format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['result']).to eq('success')
    end
  end

  describe "#find_all" do
    it "returns all transactions with the same attribute" do

      Transaction.create!(result: "success")
      Transaction.create!(result: "success")
      Transaction.create!(result: "success")
      Transaction.create!(result: "failure")

      get :find_all, result: 'success', format: :json

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "#invoice" do
    it "returns invoice associated with the transaction" do
      invoice = Invoice.create!(status: 'shipped')
      invoice.transactions.create!(credit_card_number: "1234", result: "success")
      transaction = invoice.transactions.first

      get :invoice, id: transaction.id, format: :json

      transaction_invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:success)
      expect(transaction_invoice[:id]).to eq(invoice.id)
    end
  end
end
