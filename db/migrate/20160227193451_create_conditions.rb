class CreateConditions < ActiveRecord::Migration[5.0]
  def change
    create_table :conditions do |t|
      t.integer :event_id
      t.float   :temperature
      t.float   :light
      t.float   :noise
      t.boolean :moved

      t.timestamps
    end
  end
end
