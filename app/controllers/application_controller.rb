class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_schema, :authenticate_user!

  private

    def load_schema
        Apartment::Database.switch('public')
        return unless request.subdomain.present?

        if current_account
            Apartment::Database.switch(current_account.subdomain)
        else
            redirect_to root_url(subdomain: false)
        end
    end

    def current_account
      @current_account ||= Account.find_by(subdomain: request.subdomain)          
    end

    helper_method :current_account

    def after_sign_out_path(resource_or_scope)
      new_user_session_path
    end



end
