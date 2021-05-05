class CreateCheers < ActiveRecord::Migration[6.1]
  def change
    create_table :cheers do |t|
      t.references :cheerable,  null: false, polymorphic: true
      t.references :targetable, null: false, polymorphic: true
      t.timestamps
    end
  end
end
