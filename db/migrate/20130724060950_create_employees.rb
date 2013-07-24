class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :title
      t.boolean :admin
      t.references :user
      t.references :company

      t.timestamps
    end
    add_index :employees, :user_id
    add_index :employees, :company_id
  end
end
