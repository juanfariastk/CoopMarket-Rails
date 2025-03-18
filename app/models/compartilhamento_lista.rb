class CompartilhamentoLista < ApplicationRecord
  belongs_to :user
  belongs_to :lista_compra

  validates :user_id, uniqueness: { scope: :lista_compra_id, message: "já tem acesso a essa lista." }
end
