class AddStoppedAtToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :stopped_at, :datetime
  end
end
