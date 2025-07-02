module SetCurrentUser
  extend ActiveSupport::Concern

  included do
    before_action :assign_current_user_context
    after_action  :clear_current_user_context
  end

  private

  def assign_current_user_context
    return unless user_signed_in?

    Current.user = current_user
    Company.current_company_id = current_user.company_id
  end

  def clear_current_user_context
    Current.user = nil
    Company.current_company_id = nil
  end
end
