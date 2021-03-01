class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :same_company?, only: %i[show]
  before_action :perfil_owner?, only: %i[edit update]

  def show; end

  def edit; end

  def update
    if @employee.update(employee_params)
      redirect_to employee_path(@employee)
    else
      render 'edit'
    end
  end

  private

  def employee_params
    params.require(:user).permit(:avatar, :full_name,
                                 :username, :about_me,
                                 :cpf, :employee_profile)
  end

  def same_company?
    @employee = User.find(params[:id])
    @employee.company.employee?(current_user)
  end

  def perfil_owner?
    @employee = User.find(params[:id])
    return redirect_to root_path if @employee != current_user
  end
end
