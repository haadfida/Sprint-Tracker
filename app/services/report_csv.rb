class ReportCsv
  def initialize(attributes, records)
    @attributes = attributes
    @records = records
  end

  def to_csv
    CSV.generate(headers: true) do |csv|
      csv << @attributes
      @records.each do |record|
        csv << @attributes.map { |attr| record.send(attr) }
      end
    end
  end
end
