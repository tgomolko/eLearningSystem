class AddIndexToEmail < ActiveRecord::Migration[5.2]
  def change
     add_index :emails, :email
  end
end
