class AddMostSearchedThemes < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :most_searched_themes, :text, default: [], array:true
  end
end
