class CreateCerts < ActiveRecord::Migration[8.0]
  def change
    create_table :certs do |t|
      t.string :name
      t.date :expires

      t.timestamps
    end
  end
end
