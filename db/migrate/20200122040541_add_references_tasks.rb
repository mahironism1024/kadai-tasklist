class AddReferencesTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
  end
end
