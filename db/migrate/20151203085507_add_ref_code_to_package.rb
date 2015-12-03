class AddRefCodeToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :ref_code, :string
  end
end
