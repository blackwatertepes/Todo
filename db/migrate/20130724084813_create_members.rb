class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :team
      t.references :employee
      t.boolean :leader

      t.timestamps
    end
    add_index :members, :team_id
    add_index :members, :employee_id
  end
end
