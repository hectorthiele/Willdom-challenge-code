ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'mocha/minitest'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

module SearchMock
  def google_results
    [
      {
        source: "google",
        title: "Text",
        link: "#"
      }
    ]
  end

  def bing_results
    [
        {
            source: "bing",
            title: "Text",
            link: "#"
        }
    ]
  end
end
