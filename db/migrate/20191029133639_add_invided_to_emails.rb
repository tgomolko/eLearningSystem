class AddInvidedToEmails < ActiveRecord::Migration[5.2]
  def change
    add_column :emails, :invited, :boolean, default: false
  end
end
