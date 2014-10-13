class AddReferralTypeToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :referral_type, :string
  end
end
