require 'csv'

HOST = "http://hnxss.cn"

CSV.foreach 'db/shops_detail.csv', headers: true do |row|
  name = row[1].split('/').last
  `curl -o "#{name}" "#{HOST}#{row[1]}"`
end
