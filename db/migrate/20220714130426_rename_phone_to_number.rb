class RenamePhoneToNumber < ActiveRecord::Migration[7.0]
  def change
    rename_column :phones, :mobile_phone, :number 
  end
end
