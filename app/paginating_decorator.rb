class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages
end