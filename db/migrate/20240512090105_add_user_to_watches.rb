class AddUserToWatches < ActiveRecord::Migration[7.1]
    def change
      add_reference :watches, :user
    end

end
