class Version < ApplicationRecord
  validates_presence_of :number, :package_size, :kind, :contents

  enum kind: [:shop, :car_owner]
end
