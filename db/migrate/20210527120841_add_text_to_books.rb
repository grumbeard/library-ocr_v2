class AddTextToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :text, :string, array: true
  end
end
