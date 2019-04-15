namespace :export do
  desc "Generate CSV from tracking"
  task tracking: :environment do
    csv_folder = "csv"
    csv_folder = "csv_test" if Rails.env == "test"

    time_stamp = Time.now.strftime('%Y-%m-%d-%H-%M-%S')
    csv_data = Tracking.to_csv

    File.open("public/tracking/#{csv_folder}/Tracking-#{time_stamp}-UTF8.csv", "w:utf-8") do |f|
      f.write csv_data
    end

    File.open("public/tracking/#{csv_folder}/Tracking-#{time_stamp}-ISO-8859-1.csv", "w:windows-1252") do |f|
      f.write csv_data
    end
  end
end
