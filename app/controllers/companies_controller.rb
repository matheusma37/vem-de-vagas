class CompaniesController < ApplicationController
  def edit
    @company = Company.find_by(params[:id])
  end
end
