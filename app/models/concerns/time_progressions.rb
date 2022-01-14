module TimeProgressions
  extend ActiveSupport::Concern

  included do
    def time_progression
      progress_ratio = [total_time_spent, total_estimated_time].min / ([total_time_spent, total_estimated_time].max.nonzero? || 1)
      progress_ratio.to_f * 100
    end

    def remaining_progression_percentage(time_progression_ratio)
      100 - time_progression_ratio
    end
  end
end
