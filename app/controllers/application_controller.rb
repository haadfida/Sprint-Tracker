class ApplicationController < ActionController::Base

  around_action :set_tenant_id

  before_action :authenticate_user!, except: [:list_companies, :home]
  include SetCurrentUser

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    render template: 'errors/access_denied', layout: false, status: 401
  end
  rescue_from ActionController::UnknownFormat do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

#  rescue_from ActiveRecord::RecordNotFound do |exception|
 #   binding.pry
  #  flash[:error] = exception.message
   # render template: 'errors/not_found', layout: false, status: 404
 # end

  def set_tenant_id
    Company.current_company_id = current_company&.id
    yield
  ensure
    Company.current_company_id = nil
  end

  def current_company
    return if PUBLIC_SUBDOMAINS.include? request.subdomain

    @current_company ||= Company.find_by!(subdomain: request.subdomain)
  end
end
