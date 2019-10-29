class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:name, :username, :role, :email,
                                 :password, :password_confirmation, :organization_id, :participant_org_id)
  end

  def acount_update_params
    params.require(:user).permit(:name, :username, :email, :role,
                                 :password, :password_confirmation,
                                 :current_password, :organization_id, :participant_org_id)
  end
end
