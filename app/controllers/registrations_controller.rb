class RegistrationsController < Devise::RegistrationsController

#  protected
#
 # def update_resource(resource, params)
#    resource.update_without_password(params)
#  end
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :gender)
  end
end