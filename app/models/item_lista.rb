class ItemLista < ApplicationRecord
  belongs_to :lista_compra

  validates :nome_item, presence: true
  validates :quantidade, numericality: { greater_than: 0 }
end
