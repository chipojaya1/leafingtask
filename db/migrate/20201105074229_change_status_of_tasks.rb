class ChangeStatusOfTasks < ActiveRecord::Migration[5.2]

  def up
    change_column :tasks, :status, :string, default: 'pending'
  end

  def down
    change_column :tasks, :status, :string
  end
end
