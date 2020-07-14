require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many :items }
    it { should have_many :invoices }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'class methods' do
    before(:each) do
      @merchant1 = create(:merchant)
      @merchant2 = create(:merchant)
      @merchant3 = create(:merchant)

      @item1 = create(:item, merchant: @merchant1, unit_price: 10)
      @item2 = create(:item, merchant: @merchant1, unit_price: 20.55)
      @item3 = create(:item, merchant: @merchant2, unit_price: 99.99)
      @item4 = create(:item, merchant: @merchant2, unit_price: 5.50)
      @item5 = create(:item, merchant: @merchant3, unit_price: 16.30)

      @invoice1 = create(:invoice, merchant: @merchant1)
      @invoice2 = create(:invoice, merchant: @merchant1)
      @invoice3 = create(:invoice, merchant: @merchant2)
      @invoice4 = create(:invoice, merchant: @merchant2)
      @invoice5 = create(:invoice, merchant: @merchant3)
      @invoice6 = create(:invoice, merchant: @merchant3)
      
      @invoice_item1 = create(:invoice_item, item: @item1, invoice: @invoice1, quantity: 1, unit_price: 10)
      @invoice_item2 = create(:invoice_item, item: @item2, invoice: @invoice1, quantity: 1, unit_price: 20.55)
      @invoice_item3 = create(:invoice_item, item: @item3, invoice: @invoice2, quantity: 1, unit_price: 99.99)
      @invoice_item4 = create(:invoice_item, item: @item4, invoice: @invoice3, quantity: 1, unit_price: 5.50)
      @invoice_item4 = create(:invoice_item, item: @item5, invoice: @invoice4, quantity: 1, unit_price: 15.30)
      @invoice_item4 = create(:invoice_item, item: @item5, invoice: @invoice5, quantity: 1, unit_price: 16.30)

      @transaction1 = create(:transaction, invoice: @invoice1)
      @transaction2 = create(:transaction, invoice: @invoice2)
      @transaction3 = create(:transaction, invoice: @invoice3)
      @transaction4 = create(:transaction, invoice: @invoice4, result: 'failed')
      @transaction4 = create(:transaction, invoice: @invoice5)
    end

    it 'can find merchants by revenue' do
      expect(Merchant.merchants_by_revenue(2, 'desc')).to eq([@merchant1, @merchant3])
    end 
  end
end
