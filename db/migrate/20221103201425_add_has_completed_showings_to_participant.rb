class AddHasCompletedShowingsToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :has_completed_training, :boolean
  end
end
