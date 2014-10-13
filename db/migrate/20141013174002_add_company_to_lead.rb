class AddCompanyToLead < ActiveRecord::Migration
  def change
    add_column :leads, :company, :string
  end
end
