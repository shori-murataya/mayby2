class ChangeContenttoComment < ActiveRecord::Migration[5.2]
  def up
    change_column_null :comments, :content, false, 0
  end
  
  def down
    change_column_null :comments, :content, true, nil
  end
end
