class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer    :post_id,     null: false
      t.string     :action,      null: false
      t.boolean    :checked,     null: false, default: false
      t.references :linkable,    null: false, polymorphic: true
      t.references :sendable,    null: false, polymorphic: true
      t.references :receiveable, null: false, polymorphic: true
      t.timestamps
    end
  end
end