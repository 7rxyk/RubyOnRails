class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.string :desc

      t.timestamps null: false
    end
  end
end
