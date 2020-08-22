class RenameNameAndCountAndDifficultyToPosts < ActiveRecord::Migration[5.2]

    def change
      rename_column :posts, :name, :title
      rename_column :posts, :count, :num_of_people
      rename_column :posts, :difficulty, :play_style
    end
end
