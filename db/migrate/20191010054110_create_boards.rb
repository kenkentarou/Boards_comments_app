class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.references :user

      t.timestamps
    end
    add_foreign_key :boards, :users
  end
end