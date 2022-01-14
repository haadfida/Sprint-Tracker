module DateValidations
  extend ActiveSupport::Concern

  included do
    class << self
      def validate_dates(start_date_column, end_date_column)
        validate do
          start_date = public_send start_date_column
          end_date = public_send end_date_column

          if start_date.present? && end_date.present? && start_date > end_date
            errors.add(end_date_column, I18n.t('shared.date_related_error') + start_date_column.to_s.humanize)
          end
        end
      end

      def validate_datetime(date_column)
        validate do
          date = public_send date_column
          unless (date.is_a? ActiveSupport::TimeWithZone) || date.nil? || (date.is_a? DateTime)
            errors.add date_column, I18n.t('shared.failure.invalid_date', resource_label: date.to_s.humanize)
          end
        end
      end
    end
  end
end
