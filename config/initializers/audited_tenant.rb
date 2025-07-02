# Ensure every audit record is tagged with the current tenant
Audited::Audit.class_eval do
  belongs_to :company, optional: false

  before_validation do
    self.company_id ||= Company.current_company_id
  end
end 