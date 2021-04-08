class CreateVolunteers < ActiveRecord::Migration[6.1]
  def change
    create_table :volunteers do |t|
      t.string :name,               null: false, default: ""
      t.string :place,              null: false, default: ""
      t.string :schedule,           null: false, default: ""
      t.text   :details
      t.string :expenses,                        default: ""
      t.string :conditions,                      default: ""
      t.string :application_people, null: false, default: ""
      t.string :deadline,           null: false, default: ""
      t.references :postable,    null: false, polymorphic: true
      t.timestamps
    end
  end
end
