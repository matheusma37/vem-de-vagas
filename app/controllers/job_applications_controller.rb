class JobApplicationsController < ApplicationController
  def show
    @job_opportunity = JobOpportunity.find(params[:job_opportunity_id])
    @job_applcation = JobApplication.find(params[:id])
    @candidate = @job_applcation.candidate_profile
  end
end
