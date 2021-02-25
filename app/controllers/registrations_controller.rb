class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    if current_user.admin?
      edit_company_path(current_user.company)
    else
      root_path
    end
  end
end
