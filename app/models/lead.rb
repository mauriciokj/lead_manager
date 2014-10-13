class Lead < ActiveRecord::Base
	include RdChallenge::Run
	validates :last_name, :company, :presence => true
  belongs_to :user

end
