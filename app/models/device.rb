class Device < ApplicationRecord
  has_many :devices_and_users_relationships
  has_many :users, through: :devices_and_users_relationships

  validates_uniqueness_of :uuid
end
