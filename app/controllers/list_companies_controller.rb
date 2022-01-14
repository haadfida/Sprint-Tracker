class ListCompaniesController < ApplicationController
  def list_companies
    @companies = Company.joins('INNER JOIN users ON users.company_id = companies.id').where('users.email = ?', params[:email])
    respond_to do |format|
      if @companies.any?
        format.html
      else
        format.html { redirect_to new_user_session_url, alert: t('shared.failure.fetched', resource_label: t('shared.email')) }
      end
    end
  end
end
