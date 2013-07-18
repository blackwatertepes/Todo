class CreatePrereqs < ActiveRecord::Migration
  def change
    create_table :prereqs do |t|
      t.integer :task_id
      t.integer :prereq_id

      t.timestamps
    end
  end
end
