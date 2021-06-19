class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.text       :message,   null: false
      t.boolean    :checked,   null: false, default: false
      t.references :speakable, null: false, polymorphic: true
      t.references :room,                   foreign_key: true 
      t.timestamps
    end
  end
end
