class CreateListaCompras < ActiveRecord::Migration[8.0]
  def change
    create_table :lista_compras do |t|
      t.string :nome
      t.text :descricao
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
