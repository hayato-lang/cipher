# frozen_string_literal: true

class AdminUsers::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(sign_up_params)
    render :new and return unless @admin_user.valid?

    session['devise.regist_data'] = { admin_user: @admin_user.attributes }
    session['devise.regist_data'][:admin_user]['password'] = params[:admin_user][:password]
    @admin_profile = @admin_user.build_admin_profile
    render :new_admin_profile
  end

  def create_admin_profile
    @admin_user = AdminUser.new(session['devise.regist_data']['admin_user'])
    @admin_profile = AdminProfile.new(admin_profile_params)
    render :new_admin_profile and return unless @admin_profile.valid?

    @admin_user.save
    @admin_profile.admin_user_id = @admin_user.id
    @admin_profile.save
    session['devise.regist_data']['admin_user'].clear
    sign_in(:admin_user, @admin_user)
  end

  private

  def admin_profile_params
    params.require(:admin_profile).permit(:admin_image, :postal_code, :prefecture_id, :municipality, :address,
                                          :building_name, :phone_number, :profile)
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
