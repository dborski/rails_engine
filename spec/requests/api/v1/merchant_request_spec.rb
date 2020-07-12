require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    create_list(:merchant, 5)

    @merchant1 = Merchant.first
    @merchant2 = Merchant.last

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant1)
    @item3 = create(:item, merchant: @merchant1)
    @item4 = create(:item, merchant: @merchant2)
  end

  it 'sends a list of merchants' do
    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(5)
  end

  it 'sends one merchant' do
    get api_v1_merchant_path(@merchant1)

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['attributes']['id']).to eq(@merchant1.id)
  end

  it 'can create a new merchant' do
    merchant_params = { name: 'Merchant 1' }

    post api_v1_merchants_path, params: merchant_params
    merchant = Merchant.last

    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it 'can update an existing merchant' do
    previous_name = @merchant2.name
    merchant_params = { name: 'New Merchant' }

    patch api_v1_merchant_path(@merchant2), params: merchant_params
    merchant = Merchant.find_by(id: @merchant2.id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq(merchant_params[:name])
  end

  it 'can delete an existing merchant' do
    delete api_v1_merchant_path(@merchant2)

    expect(response).to be_successful
    expect(Merchant.count).to eq(4)
  end

  it 'can get all items for a merchant' do
    get "/api/v1/merchants/#{@merchant1.id}/items"

    merchant_items = JSON.parse(response.body)

    first_item = merchant_items['data'].first

    expect(response).to be_successful
    expect(merchant_items['data'].count).to eq(3)
    expect(first_item['attributes']['id']).to eq(@item1.id)
    expect(first_item['attributes']['name']).to eq(@item1.name)
    expect(first_item['attributes']['description']).to eq(@item1.description)
    expect(first_item['attributes']['unit_price']).to eq(@item1.unit_price)
    expect(first_item['attributes']['merchant_id']).to eq(@item1.merchant_id)
  end
end
