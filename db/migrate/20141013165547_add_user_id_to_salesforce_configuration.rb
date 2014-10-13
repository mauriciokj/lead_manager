class AddUserIdToSalesforceConfiguration < ActiveRecord::Migration
  def change
    add_column :salesforce_configurations, :user_id, :integer
  end
end
