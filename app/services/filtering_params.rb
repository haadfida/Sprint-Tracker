class FilteringParams
  def initialize(issues, params)
    @issues = issues
    @params = params
  end

  def apply_filters
    if slice_params.present?
      slice_params&.each do |key, value|
        if key != 'project_id' && value.present?
          @issues = @issues.public_send('filter_by_attribute', key, value)
        end
      end
    end
    @issues
  end

  # A list of the param names that can be used for filtering the Issues
  def slice_params
    @params.slice(:priority, :status, :project_id, :creator, :reviewer, :title, :category, :assignee)
  end
end
