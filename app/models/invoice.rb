class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :transactions, dependent: :destroy

  validates_presence_of :status

  def self.total_revenue
    self.select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
        .joins(:invoice_items, :transactions)
        .merge(Transaction.successful)
  end 
end
