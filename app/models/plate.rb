class Plate < ApplicationRecord
  mount_uploader :avatar, PlateUploader
end
