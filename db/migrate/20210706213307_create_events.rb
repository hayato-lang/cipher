class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name,            null: false
      t.datetime :event_date,    null: false
      t.text :content,           null: false
      t.references :admin_user,  null: false, foreign_key: true
      t.timestamps
    end
  end
end
