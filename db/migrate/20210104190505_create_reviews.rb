class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :cleanliness
      t.string :flush_factor
      t.string :security_level
      t.integer :wait_time
      t.boolean :handicap_accessible
      t.boolean :baby_changing_station
    end
  end
end
