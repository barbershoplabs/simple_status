class ChangeStatusForTeams < ActiveRecord::Migration
  def up
    remove_column :teams, :status
    add_column :teams, :status, :integer
  end

  def down
    remove_column :teams, :status
    add_column :teams, :status, :string
  end
end
