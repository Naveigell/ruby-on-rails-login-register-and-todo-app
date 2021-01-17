class CreateTodoTodoModels < ActiveRecord::Migration[6.0]
    def change
        create_table :todo, if_not_exists: true, id: false do |table|

            table.bigint            "id", primary_key: true, auto_increment: true, null: false, unsigned: true
            table.string            "title", limit: 30, null: false
            table.string            "description", limit: 255, :null => false

            # table.timestamps
        end
    end
end
