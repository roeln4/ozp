class AddProgressToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :progress, :json
  end
end
