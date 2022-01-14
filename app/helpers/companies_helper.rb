module CompaniesHelper
  def model_count_in_search_result(search_result, model)
    model_info = search_result.aggs['_index']['buckets'].detect { |result| result['key'].include? model }
    return 0 if model_info.nil?
    model_info['doc_count']
  end
end
