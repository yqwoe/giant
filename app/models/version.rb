class Version < ApplicationRecord
  validates_uniqueness_of :number, :package_size, :type, :contents

  enum type: [:shop, :car_owner]
end
