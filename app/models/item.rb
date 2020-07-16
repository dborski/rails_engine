class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates_presence_of :name,
                        :description,
                        :unit_price

  ###s single_find and multi_find search scopes

  def self.find_one(id = nil, name = nil, description = nil, unit_price = nil, merchant_id = nil, created_at = nil, updated_at = nil)
    self.find_all(id, name, description, unit_price, merchant_id, created_at, updated_at).first
  end

  def self.find_all(id = nil, name = nil, description = nil, unit_price = nil, merchant_id = nil, created_at = nil, updated_at = nil)
    self.with_id(id)
        .with_name(name)
        .with_description(description)
        .with_unit_price(unit_price)
        .with_merchant_id(merchant_id)
        .with_created_at(created_at)
        .with_updated_at(updated_at)
  end

  scope :with_id, proc { |id|
    where("to_char(id, '999999') ILIKE ?", "%#{id}%") if id
  }

  scope :with_name, proc { |name|
    where('name ILIKE ?', "%#{name}%") if name
  }

  scope :with_description, proc { |description|
    where('description ILIKE ?', "%#{description}%") if description
  }

  scope :with_unit_price, proc { |unit_price|
    where("to_char(unit_price, '99999.99') ILIKE ?", "%#{unit_price}%") if unit_price
  }

  scope :with_merchant_id, proc { |merchant_id|
    where("to_char(merchant_id, '99999') ILIKE ?", "%#{merchant_id}%") if merchant_id
  }

  scope :with_created_at, proc { |created_at|
    where("to_char(created_at,'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{created_at}%") if created_at
  }

  scope :with_updated_at, proc { |updated_at|
    where("to_char(updated_at,'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{updated_at}%") if updated_at
  }
end
