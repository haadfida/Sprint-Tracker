module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type

    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-success'
    else
      flash_type.to_s
    end
  end

  def start_date_label(start_date)
    if start_date.present? && start_date < Date.today
      t('shared.started_on')
    else
      t('shared.starting_on')
    end
  end

  def end_date_label(end_date)
    if end_date.present? && end_date < Date.today
      t('shared.ended_on')
    else
      t('shared.due_on')
    end
  end

  def js_paginate(collection, params = {})
    will_paginate collection, params.merge(renderer: RemoteWillPaginate::LinkRenderer)
  end
end
