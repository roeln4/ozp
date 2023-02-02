class AddForeignKeysToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :correct, :boolean

    add_reference :answers, :participant, null: false
    add_reference :answers, :face, null: false
    add_foreign_key :answers, :participants, column: :participant_id
    add_foreign_key :answers, :faces, column: :face_id

  end
end
