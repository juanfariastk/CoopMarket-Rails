Rails.application.routes.draw do
  devise_for :users
  root "listas_compras#index"

  resources :listas_compras do
    resources :itens_lista, only: [:create, :destroy]
    member do
      get :compartilhar 
      post :compartilhar_usuario
      delete :remover_compartilhamento
    end
  end
end
