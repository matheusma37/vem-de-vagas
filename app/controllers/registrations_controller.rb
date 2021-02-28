class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    if current_user.admin?
      edit_company_path(current_user.company)
    elsif current_user.as_employee?
      root_path
    else
      candidate_path(current_user)
    end
  end
end
