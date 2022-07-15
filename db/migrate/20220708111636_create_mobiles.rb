class CreateMobiles < ActiveRecord::Migration[7.0]
  def change
    create_table :mobiles do |t|
      t.string :country
      t.string :mobile_phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
