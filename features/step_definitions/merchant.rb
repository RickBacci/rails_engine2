Given "I'm a merchant with no items" do
  merchant = Merchant.new(name: 'testy')
  expect(merchant.items).to eq([])
end

When(/^I request: GET \/api\/v(\d+)\/merchants\/(\d+)\/items$/) do |arg1, arg2|

  expect(response.body).to eq([])
end
