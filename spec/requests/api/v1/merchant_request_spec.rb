require 'rails_helper'

describe 'Merchants API' do
  before(:each) do
    create_list(:merchant, 5)

    @merchant1 = Merchant.first
    @merchant2 = Merchant.last
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
end
