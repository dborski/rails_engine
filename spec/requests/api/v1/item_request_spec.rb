require 'rails_helper'

describe 'Items API' do
  it 'sends a list of items' do
    create_list(:item, 5)

    get api_v1_items_path

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].count).to eq(5)
  end

  it 'sends one item' do
    item = create(:item)

    get api_v1_item_path(item)

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data']['attributes']['id']).to eq(item.id)
    expect(items['data']['attributes']['name']).to eq(item.name)
    expect(items['data']['attributes']['description']).to eq(item.description)
    expect(items['data']['attributes']['unit_price']).to eq(item.unit_price)
  end

  it 'can create a new item' do
    merchant = create(:merchant)

    body = { name: 'Item 1',
             description: 'Description 1',
             unit_price: 30.0,
             merchant_id: merchant.id }

    post api_v1_items_path, params: body
    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(body[:name])
    expect(item.description).to eq(body[:description])
    expect(item.unit_price).to eq(body[:unit_price])
    expect(item.merchant_id).to eq(body[:merchant_id])
  end

  it 'can update an existing item' do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { name: 'New Item Name',
                    description: 'New Description' }

    patch api_v1_item_path(id), params: item_params
    item = Item.find_by(id: id)

    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
  end

  it 'can delete an existing item' do
    item = create(:item)

    delete api_v1_item_path(item)

    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect { Item.find(item.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
