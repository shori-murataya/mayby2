class AddCountAndDifficultyToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :count, :string
    add_column :posts, :difficulty, :string
    
  end
end
