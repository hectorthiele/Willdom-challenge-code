class Api::V1::SearchController < Api::V1::BaseController

  def index
    search = SearchEngine.new(search_engine)

    api_response(search.perform(text_value))
  end

  def search_engine
    search_params[:engine]
  end

  def text_value
    search_params[:text]
  end

  private

  def search_params
    params.permit(:engine, :text)
  end

end
