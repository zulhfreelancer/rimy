class CreateAssets < ActiveRecord::Migration[5.2]
  def change
    create_table :assets do |t|
      t.string :type
      t.string :name
      t.string :code
      t.decimal :scale

      t.timestamps
    end

    add_index :assets, [:type]
    add_index :assets, [:code]
  end
end
