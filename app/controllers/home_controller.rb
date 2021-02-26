class HomeController < ApplicationController
  def index
    @companies = Company.all
    @job_opportunities = JobOpportunity.where(status: :enable)
                                       .where('application_deadline >= ? or application_deadline is ?',
                                              Date.today, nil)
  end
end
