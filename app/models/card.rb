class Card < ApplicationRecord
  include Queriable

  belongs_to :car
  belongs_to :growing_user
  belongs_to :user

  validates_uniqueness_of :cid, :pin

  enum status: [:inactived, :actived]
  enum channel: [:dadi, :zhongyuan, :zhumadian, :growing, :zhumadian_dadi, :zhou]

  scope :all_of_dadi, -> { where "channel = 0 OR cid LIKE 'TIMES12%'" }

  def is_actived?
    actived? ? '已激活' : '未激活'
  end

  def active!
    return if actived?

    self.actived_at = Time.zone.now
    actived!
    save
  end

  def times_card?
    cid =~/TIMES12/
  end

  class << self
    require 'roo'
    require 'roo-xls'
    def import(file)
      spreadsheet = open_spreadsheet(file)
      header = ['cid','pin','range','card_times']
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        product = find_by_id(row["id"]) || new
        # binding.pry
        product.attributes = row.to_hash
        product.save!
      end
    end

    def open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, {:expand_merged_ranges => true})
      when ".xls" then Roo::Excel.new(file.path, {:expand_merged_ranges => true})
      when ".xlsx" then Roo::Excelx.new(file.path, {:expand_merged_ranges => true})
      else raise "Unknown file type: #{file.original_filename}"
      end
    end
  end
end
