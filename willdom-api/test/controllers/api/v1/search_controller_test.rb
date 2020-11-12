require 'test_helper'

class Api::V1::SearchControllerTest < ActionDispatch::IntegrationTest
  include SearchMock

  test "should return empty array for no params provided" do
    get api_v1_search_url, as: :as_json
    assert_response :success
    results = JSON.parse(self.response.body)

    puts results

    assert_empty results, 'results is not empty'
  end

  test "should return results for google" do
    SearchEngine.any_instance.stubs(:perform).returns(google_results)
    get api_v1_search_url, as: :as_json, params: { engine: 'google', text: 'willdom' }
    assert_response :success
    results = JSON.parse(self.response.body)

    assert_not_empty results, 'results is empty or not present'
    assert_equal 'google', results[0]["source"], 'The source is not from google'
  end

  test "should return results for bing" do
    SearchEngine.any_instance.stubs(:perform).returns(bing_results)
    get api_v1_search_url, as: :as_json, params: { engine: 'bing', text: 'willdom' }
    assert_response :success
    results = JSON.parse(self.response.body)

    assert_not_empty results, 'results is empty or not present'
    assert_equal 'bing', results[0]["source"], 'The source is not from bing'
  end

  test "should return results for google and bing" do
    all_results = google_results + bing_results
    SearchEngine.any_instance.stubs(:perform).returns(all_results)
    get api_v1_search_url, as: :as_json, params: { engine: 'google_bing', text: ' Ruby on Rails' }
    assert_response :success
    results = JSON.parse(self.response.body)

    assert_not_empty results, 'results is empty or not present'
    sources = results.map {|result| result['source']}

    assert_includes sources, "bing", 'Bing was not included'
    assert_includes sources, "google", 'Google was not included'

  end

end
