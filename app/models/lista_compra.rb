class ListaCompra < ApplicationRecord
  belongs_to :user
  has_many :itens_lista, class_name: "ItemLista", dependent: :destroy
  has_many :compartilhamento_listas, class_name:"CompartilhamentoLista", dependent: :destroy
  has_many :usuarios_compartilhados, through: :compartilhamento_listas, source: :user
  accepts_nested_attributes_for :itens_lista, allow_destroy: true

  validates :nome, presence: true, length: { maximum: 150, message: "O nome da lista deve ter no máximo 150 caracteres" }
  validates :descricao, length: { maximum: 500 , message: "A descrição deve ter no máximo 500 caracteres" }
  validates :itens_lista, length: { minimum: 1, message: "A lista precisa ter pelo menos um item." }
end
