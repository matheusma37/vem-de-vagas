class HomeController < ApplicationController
  def index
    @companies = Company.all
    @job_opportunities = JobOpportunity.all.enable
  end
end
