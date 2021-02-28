class HomeController < ApplicationController
  def index
    @types = %w[empresas vagas]
    @companies = Company.all
    @job_opportunities = JobOpportunity.where(status: :enable)
                                       .where('application_deadline >= ? or application_deadline is ?',
                                              Date.today, nil)
  end

  def search
    @types = %w[empresas vagas]
    @companies = Company.where('LOWER(name) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?)',
                               "%#{params[:q]}%", "%#{params[:q]}%")

    @job_opportunities = JobOpportunity.where('LOWER(title) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?)',
                                              "%#{params[:q]}%", "%#{params[:q]}%")
                                       .where(status: :enable)
                                       .where('application_deadline >= ? or application_deadline is ?',
                                              Date.today, nil)
  end
end
