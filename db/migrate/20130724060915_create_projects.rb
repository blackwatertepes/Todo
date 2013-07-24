class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.references :company

      t.timestamps
    end
    add_index :projects, :company_id
  end
end
