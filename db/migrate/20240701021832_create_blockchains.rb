class CreateBlockchains < ActiveRecord::Migration[7.1]
  def change
    create_table :blockchains do |t|
      t.string :name, null: false
      t.bigint :avg_gas_burnt

      t.timestamps
    end
  end
end
