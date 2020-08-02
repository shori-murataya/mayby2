class ChangeNameAndHowtoToPosts < ActiveRecord::Migration[5.2]
  def up
    change_column_null :posts, :name, false, 0
    change_column_null :posts, :howto, false, 0
  end
  
  def down
    change_column_null :posts, :name, true, nil
    change_column_null :posts, :howto, true, nil
  end
end
