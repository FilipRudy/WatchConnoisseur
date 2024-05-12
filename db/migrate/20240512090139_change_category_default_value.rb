class ChangeCategoryDefaultValue < ActiveRecord::Migration[7.1]
  def change
    change_column :watches, :category, :integer, :default => 0
  end
end
