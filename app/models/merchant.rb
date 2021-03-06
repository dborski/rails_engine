class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices

  validates_presence_of :name
  
  def self.revenue_by_date_range(start_date, end_date)
    self.select("SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue")
        .joins(invoices: [:invoice_items, :transactions])
        .where('invoices.created_at BETWEEN ? AND ?', "#{start_date.to_date.beginning_of_day}", "#{end_date.to_date.end_of_day}")
        .merge(Transaction.successful)
  end 
  
  def self.merchants_by_revenue(limit = 500000, order = 'desc')
    self.select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").merge(revenue_helper(limit, order))
        .order("revenue #{order}")

  end 

  def self.merchants_by_items_sold(limit = 5, order = 'desc')
    self.select("merchants.*, SUM(invoice_items.quantity) AS items_sold").merge(revenue_helper(limit, order))
        .order("items_sold #{order}")
  end

  def self.revenue_helper(limit = 5, order = 'desc')
    self.joins(invoices: [:invoice_items, :transactions])
        .merge(Transaction.successful)
        .group(:id)
        .limit(limit)
  end
   
  ###single_find and multi_find search scopes

  def self.find_one(id = nil, name = nil, created_at = nil, updated_at = nil)
    self.find_all(id, name, created_at, updated_at).first
  end
  
  def self.find_all(id = nil, name = nil, created_at = nil, updated_at = nil)
    self.with_id(id) 
        .with_name(name)
        .with_created_at(created_at)
        .with_updated_at(updated_at)
  end

  scope :with_id, proc { |id|
    where("to_char(id, '999999') ILIKE ?", "%#{id}%") if id
  }

  scope :with_name, proc { |name|
    where('name ILIKE ?', "%#{name}%") if name
  }

  scope :with_created_at, proc { |created_at|
    where("to_char(created_at,'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{created_at}%") if created_at
  }

  scope :with_updated_at, proc { |updated_at|
    where("to_char(updated_at,'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{updated_at}%") if updated_at
  }
end
