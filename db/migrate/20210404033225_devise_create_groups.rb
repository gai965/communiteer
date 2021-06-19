# frozen_string_literal: true

class DeviseCreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      ## Database authenticatable
      t.string  :name,               null: false, default: ""
      t.string  :email,                           default: ""
      t.string  :encrypted_password, null: false, default: ""
      t.string  :phone_number,       null: false, default: ""
      t.string  :base_address,       null: false, default: ""
      t.string  :url,                             default: ""
      t.integer :group_category,     null: false
      t.string  :type,                            default: "Group"

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :groups, :email,                unique: true
    add_index :groups, :reset_password_token, unique: true
    # add_index :groups, :confirmation_token,   unique: true
    # add_index :groups, :unlock_token,         unique: true
  end
end
