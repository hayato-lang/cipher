class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false
      t.references :admin_user,  null: false
      t.timestamps
    end
  end
end
