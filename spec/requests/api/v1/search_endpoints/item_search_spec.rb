require 'rails_helper'

describe 'Item API Search' do
  before(:each) do
    @merchant1 = create(:merchant)
    @item1 = create(:item, name: 'Bicycyle', description: 'Pink bike with training wheels', unit_price: 29.45, merchant: @merchant1, created_at: 'Sat, 01 Aug 2020 12:00:00 UTC +00:00', updated_at: 'Mon, 10 Aug 2020 01:55:20 UTC +00:00')
    @item2 = create(:item, name: 'Docking station', description: 'Thunderbolt docking station', unit_price: 150.99, merchant: @merchant1, created_at: 'Sun, 14 Jul 2019 03:30:11 UTC +00:00', updated_at: 'Wed, 17 Jul 2019 10:33:00 UTC +00:00')
    @item3 = create(:item, name: 'Jeans', description: 'Blue jeans', unit_price: 32.99, merchant: @merchant1, created_at: 'Fri, 20 Dec 2019 01:30:11 UTC +00:00', updated_at: 'Fri, 17 Jan 2018 07:03:00 UTC +00:00')
    @item4 = create(:item, name: 'Gaming Station', description: 'Best gaming station', unit_price: 850.99, merchant: @merchant1, created_at: 'Fri, 20 Dec 2019 01:30:11 UTC +00:00', updated_at: 'Fri, 17 Jan 2018 07:03:00 UTC +00:00')
  end

  it 'can find an item that has a fragment in name' do

    get "/api/v1/items/find?name=cyc"

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['id']).to eq(@item1.id)
    expect(item['data']['attributes']['name']).to eq(@item1.name)
    expect(item['data']['attributes']['description']).to eq(@item1.description)
    expect(item['data']['attributes']['unit_price']).to eq(@item1.unit_price)
    expect(item['data']['attributes']['merchant_id']).to eq(@item1.merchant_id)
  end

  it 'can find an item that has a fragment in unit_price' do
    get "/api/v1/items/find?unit_price=99"

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['id']).to eq(@item2.id)
    expect(item['data']['attributes']['name']).to eq(@item2.name)
    expect(item['data']['attributes']['description']).to eq(@item2.description)
    expect(item['data']['attributes']['unit_price']).to eq(@item2.unit_price)
    expect(item['data']['attributes']['merchant_id']).to eq(@item2.merchant_id)
  end

  it 'can find an item that has a fragment in unit_price' do
    get "/api/v1/items/find?unit_price=99"

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['id']).to eq(@item2.id)
    expect(item['data']['attributes']['name']).to eq(@item2.name)
    expect(item['data']['attributes']['description']).to eq(@item2.description)
    expect(item['data']['attributes']['unit_price']).to eq(@item2.unit_price)
    expect(item['data']['attributes']['merchant_id']).to eq(@item2.merchant_id)
  end

  it 'can find an item that has a fragment in merchant_id' do
    get "/api/v1/items/find?merchant_id=#{@merchant1.id}"

    item = JSON.parse(response.body)

    expect(item['data']['attributes']['id']).to eq(@item1.id)
    expect(item['data']['attributes']['name']).to eq(@item1.name)
    expect(item['data']['attributes']['description']).to eq(@item1.description)
    expect(item['data']['attributes']['unit_price']).to eq(@item1.unit_price)
    expect(item['data']['attributes']['merchant_id']).to eq(@item1.merchant_id)
  end
  
  it 'can find an item that has a fragment all attributes' do
    get "/api/v1/items/find?name=jea&description=blue&unit_price=32&merchant_id=#{@merchant1.id}&created_at=dec&updated_at=18"
    
    item = JSON.parse(response.body)
    
    expect(item['data']['attributes']['id']).to eq(@item3.id)
    expect(item['data']['attributes']['name']).to eq(@item3.name)
    expect(item['data']['attributes']['description']).to eq(@item3.description)
    expect(item['data']['attributes']['unit_price']).to eq(@item3.unit_price)
    expect(item['data']['attributes']['merchant_id']).to eq(@item3.merchant_id)
  end

  it 'can find multiple items that have a fragment in name' do
    get "/api/v1/items/find_all?name=station"

    items = JSON.parse(response.body)

    found_items = items['data']

    expect(found_items.first['attributes']['id']).to eq(@item2.id)
    expect(found_items.first['attributes']['name']).to eq(@item2.name)
    expect(found_items.last['attributes']['id']).to eq(@item4.id)
    expect(found_items.last['attributes']['name']).to eq(@item4.name)
  end

  it 'can find multiple items that have a fragment in description and unit_price' do
    get "/api/v1/items/find_all?description=stat&unit_price=99"

    items = JSON.parse(response.body)

    found_items = items['data']

    expect(found_items.first['attributes']['id']).to eq(@item2.id)
    expect(found_items.first['attributes']['name']).to eq(@item2.name)
    expect(found_items.last['attributes']['id']).to eq(@item4.id)
    expect(found_items.last['attributes']['name']).to eq(@item4.name)
  end
end