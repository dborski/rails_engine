class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :customers, through: :invoices

  validates_presence_of :name

  def self.find_one(name = nil, created_at = nil, updated_at = nil)
    self.find_all(name, created_at, updated_at).first
  end 

  def self.find_all(name = nil, created_at = nil, updated_at = nil)
    with_name(name)
      .with_created_at(created_at)
      .with_updated_at(updated_at)
  end

  scope :with_name, proc { |name| 
    if name.present?
      where("name ILIKE ?", "%#{name}%")
    end 
  }

  scope :with_created_at, proc { |created_at| 
    if created_at.present?
      where("to_char(created_at,'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{created_at}%")
    end 
  }

  scope :with_updated_at, proc { |updated_at| 
    if updated_at.present?
      where("to_char(updated_at,'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{updated_at}%")
    end 
  }
end
