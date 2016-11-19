class AddIsPublicToThought < ActiveRecord::Migration[5.0]
  def change
    add_column :thoughts, :is_public, :bool, null: false, default: false
  end
end
