class AddVipOnlyPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :vip_only, :boolean, default: false
  end
end
