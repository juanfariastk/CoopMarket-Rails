class ItemLista < ApplicationRecord
  belongs_to :lista_compra

  validates :nome_item, presence: true
  validates :quantidade, numericality: { greater_than: 0, message:"O item não pode ter quantidade igual ou menor que zero." }
end
