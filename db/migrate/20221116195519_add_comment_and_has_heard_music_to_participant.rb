class AddCommentAndHasHeardMusicToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :comment, :string
    add_column :participants, :has_heard_music, :boolean
  end
end
