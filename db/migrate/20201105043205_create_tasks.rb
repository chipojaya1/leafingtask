class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :content
      t.datetime :duedate
      t.string :status
      t.integer :priority

      t.timestamps
    end
  end
end
