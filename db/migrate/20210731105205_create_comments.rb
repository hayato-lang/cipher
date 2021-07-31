class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :event,       null: false
      t.text :text,              null: false
      t.timestamps
    end
  end
end
