class ChangeTittleToTitleOnLead < ActiveRecord::Migration
  def change
  	rename_column(:leads, :tittle, :title)
  end
end
