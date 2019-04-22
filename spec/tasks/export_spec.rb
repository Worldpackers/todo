require "rails_helper"
require "rake"

describe "Task - export:rake" do
  before(:all) do
    load File.join(Rails.root, 'Rakefile')
    Rake::Task.define_task(:environment)

    FileUtils.mkdir_p "#{Rails.root}/public/tracking/csv_test"
    FileUtils.rm_rf(Dir.glob("#{Rails.root}/public/tracking/csv_test/*.csv"))

    Tracking.create({type_tracking:'task', json: {user: 'walterdf@gmail.com', color: '#FF0000', phrase: 'Parabéns'}.to_json })
    task = Rake::Task["export:tracking"]
    task.invoke

    @files = Dir.glob("#{Rails.root}/public/tracking/csv_test/*.csv").map{ |s| File.basename(s) }
  end

  it "csv successfully generated" do
    expect(@files.count).to eql(2)
  end

  it "check file UTF8" do
    result = @files.select{ |i| i[/Tracking-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-UTF8\.csv$/] }
    expect(result.count).to eql(1)
  end

  it "check file ISO-8859-1" do
    result = @files.select{ |i| i[/Tracking-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-ISO-8859-1\.csv$/] }
    expect(result.count).to eql(1)
  end
end
