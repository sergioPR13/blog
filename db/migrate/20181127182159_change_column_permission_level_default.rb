class ChangeColumnPermissionLevelDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :permission_level, 1
  end
end
