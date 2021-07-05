class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.references :selfable,    null: false, polymorphic: true
      t.references :partnerable, null: false, polymorphic: true
      t.timestamps
    end
  end
end
