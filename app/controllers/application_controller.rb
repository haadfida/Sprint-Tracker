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
    Company.current_company_id = current_user&.company_id
    yield
  ensure
    Company.current_company_id = nil
  end

  def current_company
    subdomain = extract_subdomain

    # In normal (sub-domain) flows we locate company by the requested sub-domain.
    unless subdomain.blank? || PUBLIC_SUBDOMAINS.include?(subdomain)
      @current_company ||= Company.find_by!(subdomain: subdomain)
      return @current_company
    end

    # When no sub-domain is present (e.g. React dev-server requests to localhost:3000)
    # fall back to the authenticated user's company – this keeps JSON API calls working
    # in development when we're outside the tenant sub-domain context.
    @current_company ||= Current.user&.company || current_user&.company
    @current_company = current_user&.company if @current_company.nil? && current_user.present?
    @current_company
  end

  def extract_subdomain
    host = request.host
    return request.subdomain if host.nil?

    if host.end_with?('.localhost')
      host.chomp('.localhost')
    elsif host.end_with?('.lvh.me')
      host.chomp('.lvh.me')
    else
      request.subdomain
    end
  end
end
