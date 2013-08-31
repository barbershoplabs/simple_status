class AddStatusToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :status, :integer
  end
end
