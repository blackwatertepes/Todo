class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.references :employee
      t.references :project

      t.timestamps
    end
    add_index :managers, :employee_id
    add_index :managers, :project_id
  end
end
