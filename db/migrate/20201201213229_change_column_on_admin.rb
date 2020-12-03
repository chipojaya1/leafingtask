class ChangeColumnOnAdmin < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :admin, false
  end
end
