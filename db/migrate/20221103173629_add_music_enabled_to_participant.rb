class AddMusicEnabledToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :music_enabled, :boolean
  end
end
