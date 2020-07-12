require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get api_v1_merchants_path

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants['data'].count).to eq(5)
  end
  it 'sends one merchant' do
    id = create(:merchant).id

    get api_v1_merchant_path(id)

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant['data']['id']).to eq(id)
  end
end
