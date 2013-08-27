class AddMailgunRouteToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :mailgun_route, :string
  end
end
