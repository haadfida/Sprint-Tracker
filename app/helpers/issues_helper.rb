# app/helpers/issues_helper

module IssuesHelper
  def get_status_color(status)
    status_color = { open: 'primary', in_progress: 'warning', resolved: 'info', closed: 'success' }
    status_color[status.to_sym]
  end

  def get_priority_color(priority)
    priority_color = { low: 'success', medium: 'warning', high: 'danger' }
    priority_color[priority.to_sym]
  end

  def get_category_color(category)
    category_color = { hotfix: 'danger', feature: 'success' }
    category_color[category.to_sym]
  end

  def filter_select(form, params)
    if params[:project_id].present?
      filters = Issue::FILTER.except(:Project)
    else
      filters = Issue::FILTER
    end
    form.select t('filter.filter_label'), filters, { include_blank: true }, { class: 'js-select-field js-filter-field form-select form-select-lg' }
  end

  def convert_to_date(date)
    date&.to_date&.to_s(:long)
  end
end
