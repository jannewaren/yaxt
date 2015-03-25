class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.text :description
      t.string :filename_user
      t.string :filename_system
      t.integer :filesize
      t.string :upload_ip

      t.timestamps null: false
    end
  end
end
