class AddContentColumnToComments < ActiveRecord::Migration
  def change
    add_column :comments, :content, :text
  end
end
