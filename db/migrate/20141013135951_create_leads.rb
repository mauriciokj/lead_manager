class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :sales_force_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
