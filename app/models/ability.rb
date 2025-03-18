class Ability
    include CanCan::Ability
  
    def initialize(user)
      return unless user
        can :create, ListaCompra
  
      can [:read], ListaCompra, compartilhamento_listas: { user_id: user.id, permissao: "leitor" }
      can [:read, :update], ListaCompra, compartilhamento_listas: { user_id: user.id, permissao: "colaborador" }
      can [:read, :update, :destroy], ListaCompra, compartilhamento_listas: { user_id: user.id, permissao: "proprietario" }
    end
  end
  