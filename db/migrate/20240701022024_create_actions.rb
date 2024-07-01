class CreateActions < ActiveRecord::Migration[7.1]
  def change
    create_table :actions do |t|
      t.references :block_transaction, null: false, foreign_key: true
      t.string :type, null: false
      t.json :data, null: false

      t.timestamps
    end

    add_index :actions, :type
  end
end
