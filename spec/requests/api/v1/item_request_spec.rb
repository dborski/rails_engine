require 'rails_helper'

describe 'Items API' do
  before(:each) do
    @merchant1 = create(:merchant)
    create_list(:item, 5, merchant: @merchant1)

    @item1 = Item.first
    @item2 = Item.last
  end

  it 'sends a list of items' do
    get api_v1_items_path

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(5)
  end

  it 'sends one item' do
    get api_v1_item_path(@item1)

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data']['attributes']['id']).to eq(@item1.id)
    expect(items['data']['attributes']['name']).to eq(@item1.name)
    expect(items['data']['attributes']['description']).to eq(@item1.description)
    expect(items['data']['attributes']['unit_price']).to eq(@item1.unit_price)
  end

  it 'can create a new item' do
    body = { name: 'Item 1',
             description: 'Description 1',
             unit_price: 30.0,
             merchant_id: @merchant1.id }

    post api_v1_items_path, params: body
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(body[:name])
    expect(item.description).to eq(body[:description])
    expect(item.unit_price).to eq(body[:unit_price])
    expect(item.merchant_id).to eq(body[:merchant_id])
  end

  it 'can update an existing item' do
    previous_name = @item2
    item_params = { name: 'New Item Name',
                    description: 'New Description' }

    patch api_v1_item_path(@item2), params: item_params
    item = Item.find_by(id: @item2.id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
  end

  it 'can delete an existing item' do
    delete api_v1_item_path(@item2)

    expect(response).to be_successful
    expect(Item.count).to eq(4)
  end
end
