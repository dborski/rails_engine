require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    @merchant1 = create(:merchant, name: 'Bills Bike Shack', created_at: 'Sat, 01 Aug 2020 12:00:00 UTC +00:00', updated_at: 'Mon, 10 Aug 2020 01:55:20 UTC +00:00')
    @merchant2 = create(:merchant, name: 'Tims Computer Shop', created_at: 'Sun, 14 Jul 2019 03:30:11 UTC +00:00', updated_at: 'Wed, 17 Jul 2019 10:33:00 UTC +00:00')
    @merchant3 = create(:merchant, name: 'Auto Mart', created_at: 'Fri, 20 Dec 2019 01:30:11 UTC +00:00', updated_at: 'Fri, 17 Jan 2018 07:03:00 UTC +00:00')
  end

  it 'can find a merchant that has a fragment in name' do
    get "/api/v1/merchants/find?name=IlL"

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['id']).to eq(@merchant1.id)
    expect(merchant['data']['attributes']['name']).to eq(@merchant1.name)
  end

  it 'can find a merchant that has a fragment in created_at' do
    get "/api/v1/merchants/find?created_at=19"

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['id']).to eq(@merchant2.id)
    expect(merchant['data']['attributes']['name']).to eq(@merchant2.name)
  end

  it 'can find a merchant that has a fragment in both name and updated_at' do
    get "/api/v1/merchants/find?name=ar&updated_at=18"

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['id']).to eq(@merchant3.id)
    expect(merchant['data']['attributes']['name']).to eq(@merchant3.name)
  end
end