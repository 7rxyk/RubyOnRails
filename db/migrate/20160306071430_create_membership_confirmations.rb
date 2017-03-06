class CreateMembershipConfirmations < ActiveRecord::Migration
  def change
    create_table :membership_confirmations do |t|
      t.integer :user_id
      t.integer :beer_club_id

      t.timestamps null: false
    end
  end
end
