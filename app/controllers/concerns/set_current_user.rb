module SetCurrentUser
  extend ActiveSupport::Concern

  included do
    around_action :set_current_user
  end

  private

  def set_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil
  end
end
