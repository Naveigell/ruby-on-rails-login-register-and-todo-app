class CreateUserUserModels < ActiveRecord::Migration[6.0]
    def change
        create_table :users, id: false, if_not_exists: true do |table|
          table.bigint        "id", primary_key: true, auto_increment: true, null: false, :unsigned => true
          table.string        "username", :limit => 40, :null => false, index: {unique: true}
          table.string        "email", :limit => 255, :null => false, index: {unique: true}
          table.string        "password", :limit => 255, :null => false
          table.column        "role", "ENUM('admin', 'user')", :null => false, :default => "admin"

          # table.timestamps
        end
    end
end
