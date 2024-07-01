class CreateBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :blocks do |t|
      t.references :blockchain, null: false, foreign_key: true
      t.string :block_id, null: false
      t.bigint :height, null: false
      t.string :block_hash, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.datetime :time, null: false
    end

    add_index :blocks, :block_hash, unique: true
    add_index :blocks, :created_at
  end
end
