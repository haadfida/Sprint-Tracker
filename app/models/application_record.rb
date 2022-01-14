class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.inherited(subclass)
    super
    self.per_page = RECORDS_PER_PAGE
    subclass.instance_eval do
      def subclass.not_multitenant
        @multitenant = false
      end

      def subclass.multitenant?
        @multitenant.nil? || @multitenant
      end
    end

    return if ENV['DISABLE_TENANT'] == 'true'

    trace = TracePoint.new(:end) do |tp|
      if tp.self == subclass
        trace.disable
        if tp.self.multitenant?
          subclass.instance_eval { default_scope { where(company_id: Company.current_company_id) } }
        end
      end
    end
    trace.enable
  end
end
