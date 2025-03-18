class CreateItemLista < ActiveRecord::Migration[8.0]
  def change
    create_table :item_lista do |t|
      t.string :nome_item
      t.integer :quantidade
      t.text :observacoes
      t.references :lista_compra, null: false, foreign_key: true

      t.timestamps
    end
  end
end
