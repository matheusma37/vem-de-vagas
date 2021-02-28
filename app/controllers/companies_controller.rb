class CompaniesController < ApplicationController
  before_action :admin?, only: %i[edit update]

  def show
    @company = Company.find_by(params[:id])
    @job_opportunities = if @company&.employee?(current_user)
                           @company.job_opportunities
                         else
                           @company.job_opportunities
                                   .where(status: :enable)
                                   .where('application_deadline >= ? or application_deadline is ?',
                                          Date.today, nil)
                         end
  end

  def edit
    @company = Company.find_by(params[:id])
  end

  def update
    @company = Company.find_by(params[:id])
    if @company.update(params.require(:company)
                              .permit(:name, :description,
                                      :cnpj, :creation_date,
                                      :address, :site,
                                      :cover, :logo))
      redirect_to @company, notice: 'Empresa atualizada com sucesso!'
    else
      render 'edit'
    end
  end

  private

  def admin?
    unless current_user.admin?
      redirect_to company_path(current_user.company),
                  alert: 'Apenas o administrador pode editar as informações da empresa'
    end
  end
end
