class SearchController < ApplicationController
  def index
  end

  def search
    render json: params.as_json
  end
end
