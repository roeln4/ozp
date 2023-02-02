class AddLockedToAnswer < ActiveRecord::Migration[7.0]
  def change
    add_column :answers, :is_locked, :boolean
  end
end
