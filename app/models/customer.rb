class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :merchants, through: :invoices

  validates_presence_of :first_name,
                        :last_name

  def self.spent_at_merchant(merchant_id, quantity = 3)
    self.select("customers.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_spent")
        .joins(invoices: [:invoice_items, :transactions])
        .where('invoices.merchant_id = ?', "#{merchant_id}")
        .merge(Transaction.successful)
        .group(:id)
        .order('total_spent DESC')
        .limit("#{quantity}")
  end
end
