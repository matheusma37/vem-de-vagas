class JobOpportunitiesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update enable disable apply]

  def show
    @job_opportunity = JobOpportunity.find(params[:id])
    @company = @job_opportunity.company
    return redirect_to root_path unless job_opportunity_valid?
  end

  def new
    company_employee?
    @company = Company.find(params[:company_id])
    @job_opportunity = JobOpportunity.new
  end

  def create
    company_employee?
    @job_opportunity = JobOpportunity.new(job_opportunity_params)
    @job_opportunity.company = current_user.company
    if @job_opportunity.save
      redirect_to @job_opportunity.company, notice: 'Vaga criada com sucesso'
    else
      @company = Company.find(params[:company_id])
      render 'new', alert: 'Não foi possível criar a vaga'
    end
  end

  def edit
    company_employee?
    @job_opportunity = JobOpportunity.find(params[:id])
  end

  def update
    company_employee?
    @job_opportunity = JobOpportunity.find(params[:id])
    if @job_opportunity.update(job_opportunity_params)
      redirect_to company_job_opportunity_path(@job_opportunity.company, @job_opportunity)
    else
      @company = Company.find(params[:company_id])
      render 'edit'
    end
  end

  def enable
    company_employee?
    @job_opportunity = JobOpportunity.find(params[:id])
    @job_opportunity.enable! if @job_opportunity.disable?
    redirect_to company_job_opportunity_path(@job_opportunity.company, @job_opportunity)
  end

  def disable
    company_employee?
    @job_opportunity = JobOpportunity.find(params[:id])
    @job_opportunity.disable! if @job_opportunity.enable?
    redirect_to company_job_opportunity_path(@job_opportunity.company, @job_opportunity)
  end

  def apply
    job_opportunity = JobOpportunity.find(params[:id])
    return redirect_to company_path(job_opportunity.company) if job_opportunity.company.employee?(current_user)

    JobApplication.create(candidate_profile: current_user.candidate_profile, job_opportunity: job_opportunity)
    redirect_to company_job_opportunity_path(job_opportunity.company, job_opportunity),
                notice: 'Sua candidatura já foi enviada, aguarde por uma resposta'
  end

  private

  def job_opportunity_params
    params.require(:job_opportunity).permit(:title, :description,
                                            :min_salary, :max_salary,
                                            :application_deadline,
                                            :total_job_opportunities, :professional_level)
  end

  def company_employee?
    company = Company.find(params[:company_id])
    return redirect_to root_path unless company.employee?(current_user)
  end

  def job_opportunity_valid?
    if !@job_opportunity&.company&.employee?(current_user) &&
       (@job_opportunity.nil? || @job_opportunity.disable?)
      return false
    end

    true
  end
end
