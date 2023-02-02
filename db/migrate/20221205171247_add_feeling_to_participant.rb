class AddFeelingToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :feeling, :text
  end
end
