class CreateAdminProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_profiles do |t|
      t.string     :postal_code,          null: false
      t.integer    :prefecture_id,        null: false
      t.string     :municipality,         null: false
      t.string     :address,              null: false
      t.string     :building_name        
      t.string     :phone_number,         null: false
      t.text       :profile,              null: false
      t.references :admin_user,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
