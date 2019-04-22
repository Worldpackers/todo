require "csv"

class Tracking < ApplicationRecord
  validates :json, presence: true

  def self.to_csv(options = {})
    CSV.generate(headers: true, row_sep: "\r\n") do |csv_file|
      csv_file << csv_header_row

      all.each do |tracking|
        csv_file << tracking.to_csv
      end
    end
  end

  def self.csv_header_row
    %w(id type_tracking user color phrase hour)
  end

  def to_csv
    hash = JSON.parse(json,:symbolize_names => true)
    [id, type_tracking, hash[:user], hash[:color], hash[:phrase], created_at.to_datetime.hour]
  end
end
