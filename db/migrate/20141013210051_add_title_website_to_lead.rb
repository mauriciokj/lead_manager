class AddTitleWebsiteToLead < ActiveRecord::Migration
  def change
    add_column :leads, :tittle, :string
    add_column :leads, :website, :string
  end
end
