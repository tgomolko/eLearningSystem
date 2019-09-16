class AddReferencesToPage < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :page, foreign_key: true
  end
end
