class CreateCompartilhamentoListas < ActiveRecord::Migration[8.0]
  def change
    create_table :compartilhamento_listas do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lista_compra, null: false, foreign_key: true
      t.string :permissao

      t.timestamps
    end
  end
end
