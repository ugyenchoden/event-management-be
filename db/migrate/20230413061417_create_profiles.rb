class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.references :user, null: false, type: :uuid
      t.string :firstname, default: '', null: false
      t.string :lastname, default: '', null: false
      t.string :phone, null: false

      t.timestamps
    end

    add_index :profiles, %i[firstname lastname]
  end
end
