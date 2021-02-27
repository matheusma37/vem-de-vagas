class JobOpportunitiesController < ApplicationController
  def show
    @job_opportunity = JobOpportunity.find(params[:id])
  end

  def new
    @job_opportunity = JobOpportunity.new
  end

  def create
    @job_opportunity = JobOpportunity.new(job_opportunity_params)
    @job_opportunity.company = current_user.company
    if @job_opportunity.save
      redirect_to @job_opportunity.company, notice: 'Vaga criada com sucesso'
    else
      render 'new', alert: 'Não foi possível criar a vaga'
    end
  end

  private

  def job_opportunity_params
    params.require(:job_opportunity).permit(:title, :description,
                                            :min_salary, :max_salary,
                                            :application_deadline,
                                            :total_job_opportunities, :professional_level)
  end
end
