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

  test "an ActiveShipping::ResponseError with invalid zipcode" do
    assert_raises ActiveShipping::ResponseError do

      get :find_rate,  {
        "weight" => 10,
        "state" => "WA",
        "city" => "Seattle",
        "zip" => "99999"
      }
    end
  end

  test "an ActiveShipping::ResponseError with a weight over 90 pounds" do
    assert_raises ActiveShipping::ResponseError do

      get :find_rate,  {
        "weight" => 100000,
        "state" => "WA",
        "city" => "Seattle",
        "zip" => "98118"
      }
    end
  end

  test "an ActiveShipping::ResponseError when the zipcode does not match the state" do
    assert_raises ActiveShipping::ResponseError do

      get :find_rate,  {
        "weight" => 9,
        "state" => "WA",
        "city" => "Seattle",
        "zip" => "02131"
      }
    end
  end
end
