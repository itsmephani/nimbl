require 'csv' 
class SearchController < ApplicationController
  def index
  end

  def search
    render json: params.as_json
  end

  def file_upload
    if params[:file].present? && params[:file].content_type == "text/csv"
      #begin
        keywords = []
        file = params[:file].read
        keywords = CSV.parse(file)
        keywords = keywords.flatten!.compact
        Search.new keywords    
        render status: 200, json: {message: "Ok"}
      #rescue 
      #  render status: 406, json: {message:  "Some thing went wrong, Try Again!"}
      #end
    else
      render status: 403, json: {message:  "Invalid Format, Try Again!"}
    end
  end

end
