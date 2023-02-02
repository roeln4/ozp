class AddPropertiesToParticipant < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :gender, :string
    add_column :participants, :age, :integer
    add_column :participants, :current_study, :string
  end
end
