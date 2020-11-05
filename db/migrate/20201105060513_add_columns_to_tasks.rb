class AddColumnsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :duedate, :datetime
    add_column :tasks, :priority, :integer
    add_column :tasks, :status, :string
  end
end
