class CreateTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :trackings do |t|
      t.string :type_tracking
      t.text :json

      t.timestamps
    end
  end
end
