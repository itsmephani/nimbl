require 'csv' 
class SearchController < ApplicationController
  def index
  end

  def file_upload
    if params[:file].present? && params[:file].content_type == "text/csv"
      #begin
        keywords = []
        file = params[:file].read
        keywords = CSV.parse(file)
        keywords = keywords.flatten!.compact
        SearchJob.perform_later keywords
        results = Result.having_keyword({q: keywords[0]}).offset(0).limit(10)
        render status: 200, json: {message: "Ok", results: results, keyword: keywords[0]}
      #rescue 
      #  render status: 406, json: {message:  "Some thing went wrong, Try Again!"}
      #end
    else
      render status: 403, json: {message:  "Invalid Format, Try Again!"}
    end
  end

end
