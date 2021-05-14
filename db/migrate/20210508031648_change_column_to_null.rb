class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def up
    change_column_null :room_users, :room_id, true
  end

  def down
    change_column_null :room_users, :user_id, false
  end
end
