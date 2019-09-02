class AddAasmStateToOrganizations < ActiveRecord::Migration[5.2]
  def change
    add_column :organizations, :aasm_state, :string
  end
end
