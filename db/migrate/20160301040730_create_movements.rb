class CreateMovements < ActiveRecord::Migration[5.0]
  def change
    create_table :movements do |t|
      t.integer :event_id

      t.timestamps
    end
  end
end
