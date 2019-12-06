class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.text :content
      t.string :title
      t.references :course, foreign_key: true

      t.timestamps
    end
  end
end
