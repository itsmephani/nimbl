class SearchJob < ActiveJob::Base
  queue_as :default

  def perform(keywords)
    Search.new keywords
  end
end
