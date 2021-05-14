class ChangeColumnNull < ActiveRecord::Migration[6.0]
    def up
      change_column_null :room_users, :user_id, true
    end
end
