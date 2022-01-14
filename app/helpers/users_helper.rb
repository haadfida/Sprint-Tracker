module UsersHelper
  def user_roles_dropdown_options_for_select
    User::ROLE_ID.map { |label, id| [label.capitalize, id] }
  end

  def role_name(role_id, user_id)
    case role_id
    when 1
      if user_id == Company.current_company.owner_id
        'Company Owner'
      else
        'Admin'
      end
    when 2
      'Member'
    end
  end
end
