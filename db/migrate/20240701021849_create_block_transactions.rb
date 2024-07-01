class CreateBlockTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :block_transactions do |t|
      t.references :block, null: false, foreign_key: true
      t.string :hash, null: false
      t.string :sender, null: false
      t.string :receiver, null: false
      t.bigint :gas_burnt, null: false
      t.integer :actions_count, null: false
      t.boolean :success, null: false

      t.timestamps
    end

    add_index :block_transactions, :hash, unique: true
    add_index :block_transactions, :gas_burnt
  end
end
