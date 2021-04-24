class CreateJoinVolunteers < ActiveRecord::Migration[6.1]
  def change
    create_table :join_volunteers do |t|
      t.string   :name,            null: false, default: ""
      t.string   :phone_number
      t.integer  :number,          null: false
      t.text     :inquiry
      t.references :user,      foreign_key: true
      t.references :volunteer, foreign_key: true
      t.timestamps
    end
  end
end
