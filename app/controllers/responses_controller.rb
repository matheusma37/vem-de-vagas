class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def refusal
    refusal_response = RefusalResponse.new(refusal_response_params)
    @company = Company.find(params[:company_id])
    @job_opportunity = JobOpportunity.find(params[:job_opportunity_id])
    @job_application = JobApplication.find(params[:job_application_id])

    refusal_response.job_application = @job_application
    save_reponse(refusal_response,
                 notice: 'Candidatura recusada com sucesso',
                 alert: 'Não foi possível recusar essa candidatura',
                 &:refused!)
  end

  def proposal
    proposal_response = ProposalResponse.new(proposal_response_params)
    @company = Company.find(params[:company_id])
    @job_opportunity = JobOpportunity.find(params[:job_opportunity_id])
    @job_application = JobApplication.find(params[:job_application_id])

    proposal_response.job_application = @job_application
    save_reponse(proposal_response,
                 notice: 'Proposta feita com sucesso',
                 alert: 'Não foi possível fazer uma proposta para essa candidatura',
                 &:responded!)
  end

  private

  def proposal_response_params
    params.require(:proposal_response).permit(:message, :start_date, :salary_proposal)
  end

  def refusal_response_params
    params.require(:refusal_response).permit(:reason, :refuser)
  end

  def save_reponse(response, notice:, alert:)
    if response.save
      yield @job_application
      redirect_to company_job_opportunity_job_application_path(@company,
                                                               @job_opportunity,
                                                               @job_application), notice: notice
    else
      redirect_to company_job_opportunity_job_application_path(@company,
                                                               @job_opportunity,
                                                               @job_application), alert: alert
    end
  end
end
