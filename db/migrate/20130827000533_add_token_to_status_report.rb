class AddTokenToStatusReport < ActiveRecord::Migration
  def change
    add_column :status_reports, :token, :string
  end
end
