class CandidatesController < ApplicationController
  def show
    @candidate = User.find(params[:id])
  end
end
