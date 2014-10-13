class CreateSalesforceConfigurations < ActiveRecord::Migration
  def change
    create_table :salesforce_configurations do |t|
      t.string :client_id
      t.string :client_secret
      t.string :username
      t.string :password
      t.string :security_token

      t.timestamps
    end
  end
end
