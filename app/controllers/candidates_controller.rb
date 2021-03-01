class CandidatesController < ApplicationController
  before_action :authenticate_user!
  before_action :perfil_owner?, only: %i[edit update]

  def show
    @candidate = User.find(params[:id])
  end

  def edit; end

  def update
    if @candidate.update(candidate_params)
      redirect_to candidate_path(@candidate)
    else
      render 'edit'
    end
  end

  private

  def candidate_params
    params.require(:user).permit(:avatar, :full_name,
                                 :username, :about_me,
                                 :cpf, :candidate_profile)
  end

  def perfil_owner?
    @candidate = User.find(params[:id])
    return redirect_to root_path if @candidate != current_user
  end
end
