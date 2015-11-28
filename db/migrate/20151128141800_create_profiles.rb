class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name, :null => false
      t.string :address, :null => false
      t.string :phone, :null => false
      t.float :latitude
      t.float :longitude
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
