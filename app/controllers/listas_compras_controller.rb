class ListasComprasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lista, only: %i[show edit update destroy compartilhar compartilhar_usuario remover_compartilhamento usuarios_compartilhados]

  def index
    @listas = ListaCompra.joins(:compartilhamento_listas)
                         .where(compartilhamento_listas: { user_id: current_user.id })
                         .distinct
  end   

  def show
    authorize! :read, @lista
  end

  def new
    @lista = ListaCompra.new
    @lista.itens_lista.build
  end    

  def create
    @lista = current_user.listas_compras.build(lista_params)
  
    if @lista.save
      CompartilhamentoLista.create!(user: current_user, lista_compra: @lista, permissao: "proprietario")
      redirect_to listas_compra_path(@lista), notice: "Lista criada com sucesso."
    else
      flash.now[:error] = @lista.errors.messages.values.flatten.join("<br>").html_safe
      render :new, status: :unprocessable_entity
    end
  end
   
  def edit
    authorize! :update, @lista
  end

  def update
    authorize! :update, @lista
    puts "Parâmetros recebidos no update: #{params[:lista_compra].inspect}"

    if @lista.update(lista_params)
      redirect_to listas_compra_path(@lista), notice: "Lista atualizada com sucesso."
    else
      flash.now[:error] = @lista.errors.messages.values.flatten.join("<br>").html_safe
      render :edit, status: :unprocessable_entity
    end
  end  

  def destroy
    authorize! :destroy, @lista
    puts "Usuário #{current_user.id} tentando excluir a lista #{@lista.id}"
    
    if @lista.destroy
      respond_to do |format|
        format.html { redirect_to listas_compras_path, notice: "Lista removida." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to listas_compras_path, alert: "Erro ao excluir a lista." }
        format.json { render json: { error: "Erro ao excluir" }, status: :unprocessable_entity }
      end
    end
  end

  def compartilhar_usuario
    authorize! :update, @lista
    
    email = params[:email].strip
    permissao = params[:permissao]
    usuario = User.find_by(email: email)
  
    if email.blank?
      flash[:alert] = "O campo de e-mail não pode estar vazio."
    elsif usuario.nil?
      flash[:alert] = "Nenhum usuário encontrado com este e-mail."
    elsif @lista.usuarios_compartilhados.include?(usuario)
      flash[:alert] = "Este usuário já tem acesso à lista."
    elsif !%w[leitor colaborador].include?(permissao)
      flash[:alert] = "Permissão inválida."
    else
      CompartilhamentoLista.create!(user: usuario, lista_compra: @lista, permissao: permissao)
      flash[:notice] = "Usuário adicionado com sucesso como #{permissao}!"
    end
  
    redirect_to compartilhar_listas_compra_path(@lista)
  end   

  def remover_compartilhamento
    authorize! :update, @lista

    usuario = User.find_by(id: params[:usuario_id])
    if usuario && @lista.usuarios_compartilhados.include?(usuario)
      @lista.usuarios_compartilhados.delete(usuario)
      flash[:notice] = "Usuário removido com sucesso."
    else
      flash[:alert] = "Usuário não encontrado ou já removido."
    end

    redirect_to compartilhar_listas_compra_path(@lista)
  end
  
  def usuarios_compartilhados
    authorize! :read, @lista
    render json: @lista.usuarios_compartilhados.select(:id, :name, :email)
  end  
   
  def compartilhar
    authorize! :read, @lista
  end
  
  private

  def set_lista
    @lista = ListaCompra.joins(:compartilhamento_listas)
                        .where(compartilhamento_listas: { user_id: current_user.id })
                        .find_by(id: params[:id])
  
    redirect_to listas_compras_path, alert: "Lista não encontrada ou sem permissão." if @lista.nil?
  end  
     
  def lista_params
    params.require(:lista_compra).permit(:nome, :descricao, itens_lista_attributes: [:id, :nome_item, :quantidade, :observacoes, :_destroy])
  end
end  
