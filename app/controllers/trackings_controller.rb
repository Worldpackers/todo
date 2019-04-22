class TrackingsController < ApplicationController
  layout 'tracking_csv_files'
  def index
    @files = Dir.glob("#{Rails.root}/public/tracking/csv/*.csv").map{ |s| File.basename(s) }
  end
end
