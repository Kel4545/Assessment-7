class UserList < ActiveRecord::Migration
  class CreateUsers < ActiveRecord::Migration
    def up
      create_table :users do |t|
        t.string :username
        t.string :message
      end
    end

    def down
      drop_table :users
    end

  end
end
