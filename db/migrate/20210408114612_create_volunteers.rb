class CreateVolunteers < ActiveRecord::Migration[6.1]
  def change
    create_table :volunteers do |t|
      t.string     :title,              null: false, default: ""
      t.string     :place,              null: false, default: ""
      t.text       :details
      t.date       :schedule,           null: false
      t.time       :start_time
      t.time       :end_time
      t.string     :expenses,                        default: ""
      t.string     :conditions,                      default: ""
      t.integer    :application_people, null: false
      t.date       :deadline,           null: false
      t.integer    :participant_number,              default: 0
      t.boolean    :contributor_flag,   null: false, default: false
      t.boolean    :deadline_flag,   null: false, default: false
      t.references :postable,           null: false, polymorphic: true
      t.timestamps
    end
  end
end
