class AddWatchesTable < ActiveRecord::Migration[7.1]
    def change
      create_table :watches do |t|
        t.string :name, null: false
        t.string :description, null: false
        t.string :category, null: false
        t.bigint :price, null: false
        t.string :photo_url, null: false
        t.timestamps
      end
    end

end
