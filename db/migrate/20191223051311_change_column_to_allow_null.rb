class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :crypted_password, :string, null: true
  end

  def down
    change_column :users, :crypted_password, :string, null: false
  end
end
