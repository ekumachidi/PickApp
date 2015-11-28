class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :tracking_code, :null => false
      t.integer :weight, :null => false
      t.string :vendor, :null => false
      t.string :location, :null => false
      t.string :destination
      t.string :recipient
      t.string :r_contact
      t.time :due_at
      t.boolean :status, :default => false
      t.boolean :dispatch, :default => false
      t.boolean :assigned, :default => false
      t.float :latitude
      t.float :longitude
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
