class CreateStorageHosts < ActiveRecord::Migration[6.0]
  def change
    create_table :storage_hosts do |t|
      t.string :name, nullable: false

      t.timestamps
    end

    add_index :storage_hosts, :name, unique: true
  end
end
