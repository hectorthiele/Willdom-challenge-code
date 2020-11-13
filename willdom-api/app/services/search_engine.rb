require 'net/https'
require 'uri'
require 'json'

class SearchEngine
  attr_reader :search_engine, :text

  GOOGLE_ENGINE = 'google'.freeze
  BING_ENGINE = 'bing'.freeze
  GOOGLE_BING = 'google_bing'.freeze

  ENGINE_OPTIONS = [GOOGLE_ENGINE, BING_ENGINE, GOOGLE_BING]

  def initialize(search_engine)
    @search_engine = search_engine
  end

  def perform(text)
    response = []
    response += do_search(GOOGLE_ENGINE, text) if search_in_google?
    response += do_search(BING_ENGINE, text) if search_in_bing?
    response
  end

  private

  def do_search(engine, text)

    endpoint = engine == GOOGLE_ENGINE ? google_api_endpoint : bing_api_endpoint
    uri = URI("#{endpoint}q=#{URI.escape(text)}")

    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = bing_api_key if engine == BING_ENGINE

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    data = JSON.parse(response.body)
    return normalize_google_resource(data) if engine == GOOGLE_ENGINE
    return normalize_bing_resource(data) if engine == BING_ENGINE
  end

  def normalize_google_resource(data)
    results = []
    (data['items'] || []).each do |result|
      result_data = {}
      result_data[:source] = GOOGLE_ENGINE
      result_data[:title] = result['title']
      result_data[:link] = result['link']
      result_data[:snippet] = result['snippet']

      results << result_data
    end
    results
  end

  def normalize_bing_resource(data)
    results = []
    bing_data = data['webPages'] || {}
    (bing_data['value'] || []).each do |result|
      result_data = {}
      result_data[:source] = BING_ENGINE
      result_data[:title] = result['name']
      result_data[:link] = result['url']
      result_data[:snippet] = result['snippet']

      results << result_data
    end
    results
  end

  def search_in_google?
    search_engine == GOOGLE_ENGINE || both_engine?
  end

  def search_in_bing?
    search_engine == BING_ENGINE || both_engine?
  end

  def both_engine?
    search_engine == GOOGLE_BING
  end

  def google_api_endpoint
    "https://www.googleapis.com/customsearch/v1?key=#{google_api_key}&cx=12f71075bc76ff1c7&"
  end

  def google_api_key
    ENV['GOOGLE_API_KEY'] ||'AIzaSyAMX-eUI4e_otj_OdH1SJAbZjJOLvKKtZY'
  end

  def bing_api_endpoint
    'https://api.bing.microsoft.com/v7.0/search?'
  end

  def bing_api_key
    ENV['BING_API_KEY'] || '68795442290c4204989e5cf9f048c193'
  end
end