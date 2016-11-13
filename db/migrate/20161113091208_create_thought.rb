class CreateThought < ActiveRecord::Migration[5.0]
  def change
    create_table :thoughts do |t|
      t.references :user, foreign_key: true, null: false
      t.text :content

      t.timestamps
    end
    add_index :thoughts, :created_at
  end
end
