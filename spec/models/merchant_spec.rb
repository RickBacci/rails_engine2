require 'rails_helper'

RSpec.describe Merchant, type: :model do
  let(:merchant) { Merchant.create!(name: 'test merchant') }

  context 'can have a collection of items' do

    it 'that starts out empty' do
      expect(merchant.items).to eq([])
    end

    it 'that can be added to' do
      merchant.items.create!(name: 'item1', description: 'item1 description')

      expect(merchant.items.size).to eq(1)
    end
  end
end
