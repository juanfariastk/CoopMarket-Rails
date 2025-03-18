class User < ApplicationRecord
  # Include default devise modules. Others available are:
  has_many :listas_compras, class_name: 'ListaCompra', dependent: :destroy
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "inválido" }
end
