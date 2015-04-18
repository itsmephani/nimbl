class ResultsController < ApplicationController

  def index
    Search.new [params[:q]] if params[:offset].to_i == 0
    results = params[:scope].present? ? Result.send(params[:scope], params) : Result.all
    count = results.count
    results = results.paginate(params)
    keyword = results.first.keyword    
    render json: {keyword: keyword, count: count, results: results, no_of_adwords_top: keyword.pages.first.try(:no_of_adwords_top), no_of_adwords_right: keyword.pages.first.try(:no_of_adwords_right), no_of_non_adwords_results: keyword.pages.first.try(:no_of_non_adwords_results)}
  end
end
