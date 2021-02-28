class EmployeesController < ApplicationController
  before_action :same_company?, only: %i[show]

  def show; end

  private

  def same_company?
    @employee = User.find(params[:id])
    @employee.company.employee?(current_user)
  end
end
