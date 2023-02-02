class AddRatingToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :rating, :integer
  end
end
