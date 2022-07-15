class RenameMobileToPhone < ActiveRecord::Migration[7.0]
  def change
    rename_table :mobiles, :phones
  end
end
