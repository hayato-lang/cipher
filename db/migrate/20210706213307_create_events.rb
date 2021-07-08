class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.text :content,           null: false 
      t.date :event_date,        null: false 
      t.references :admin_user,  null: false, foreign_key: true 
      t.timestamps
    end
  end
end
