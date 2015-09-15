Given "I'm a registered merchant with an id of $id" do |id|

  @merchant = Merchant.new(id: id, name: 'testy')
  @merchant.save!

  expect(@merchant).to be_valid
end

Given "I have no items" do
  expect(@merchant.items).to eq([])
end

When "I request: GET /api/v1/merchants/$id/items" do
  expect(response.status).to eq("200")
  expect(response.body).to eq("")
end

