require 'test_helper'
require 'active_shipping'

class PackagesControllerTest < ActionController::TestCase

  setup do
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  test "when #find_rate invoked package rate is returned" do
    params = {
      "weight" => 10,
      "state" => "WA",
      "city" => "Seattle",
      "zip" => "98102"
    }
    post :find_rate, params

    assert_match 'application/json', response.header['Content-Type']
    body = JSON.parse(response.body)

    assert_instance_of Hash, body
    assert_response :created
  end

  # test "when a zipcode that doesn't exist is given return no content" do
  #    get :find_rate,  {
  #        "weight" => 10,
  #        "state" => "WA",
  #        "city" => "Seattle",
  #        "zip" => "98102"
  #      }
  #      assert_response :not_found
  #     #  assert_emptys
  # end
end
