class CompaniesController < ApplicationController
  def search
    @results = Searchkick.search params[:query], models: [Project, Sprint, Issue, User], match: :word_middle, aggs: [:_index], page: params[:page], per_page: RECORDS_PER_PAGE
    respond_to do |format|
      format.html
    end
  end
end
