class MakeUserIdNonNullable < ActiveRecord::Migration[7.1]
  def change
    change_column :watches, :user_id, :integer, null: false
  end
end
