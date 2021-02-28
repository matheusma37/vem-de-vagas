class JobOpportunitiesController < ApplicationController
  def show
    @job_opportunity = JobOpportunity.find(params[:id])
    unless @job_opportunity&.company&.employee?(current_user)
      return redirect_to root_path unless @job_opportunity
      return redirect_to root_path if @job_opportunity.disable?

      if @job_opportunity.application_deadline && @job_opportunity.application_deadline < Date.today
        redirect_to root_path
      end
    end
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

  def edit
    @job_opportunity = JobOpportunity.find(params[:id])
  end

  def update
    @job_opportunity = JobOpportunity.find(params[:id])
    if @job_opportunity.update(job_opportunity_params)
      redirect_to @job_opportunity
    else
      render 'edit'
    end
  end

  def enable
    @job_opportunity = JobOpportunity.find(params[:id])
    @job_opportunity.enable! if @job_opportunity.disable?
    redirect_to @job_opportunity
  end

  def disable
    @job_opportunity = JobOpportunity.find(params[:id])
    @job_opportunity.disable! if @job_opportunity.enable?
    redirect_to @job_opportunity
  end

  private

  def job_opportunity_params
    params.require(:job_opportunity).permit(:title, :description,
                                            :min_salary, :max_salary,
                                            :application_deadline,
                                            :total_job_opportunities, :professional_level)
  end
end
