require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'validations' do
    it { should validate_presence_of :status }
  end

  describe 'merchant_customers_relationship' do
    it { should belong_to :customer }
    it { should belong_to :merchant }
  end

  describe 'invoice_items_relationship' do
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items)}
  end
end
