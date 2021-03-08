class JobApplicationsController < ApplicationController
  before_action :authenticate_user!

  def show
    @job_opportunity = JobOpportunity.find(params[:job_opportunity_id])
    @job_application = JobApplication.find(params[:id])
    @candidate = @job_application.candidate_profile
    @refusal_response = RefusalResponse.new
  end
end
