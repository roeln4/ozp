class AddDeletedAtToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :deleted_at, :datetime
    add_index :participants, :deleted_at
  end
end
