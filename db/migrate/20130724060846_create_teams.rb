class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :company

      t.timestamps
    end
    add_index :teams, :company_id
  end
end
