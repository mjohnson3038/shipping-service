require 'test_helper'

class PackagesControllerTest < ActionController::TestCase
  setup do
  @request.headers['Accept'] = Mime::JSON
  @request.headers['Content-Type'] = Mime::JSON.to_s
end
end
