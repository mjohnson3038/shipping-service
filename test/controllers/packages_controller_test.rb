require 'test_helper'
require 'active_shipping'

class PackagesControllerTest < ActionController::TestCase

  setup do
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  test "when #find_rate invoked package rate is returned" do
    # ORIGIN = country: "US", state: 'WA', city: 'Seattle', postal_code: '98102'
    # DESTINATION = state: "WA", city: Seattle: postal_code: "98102"
    package_data = {
      "orgin" => {"state" => "WA", "city" => "Seattle", "postal_code" => "98112"},
      "weight" => 10,
      "destination" => {"state" => "WA", "city" => "Seattle", "postal_code" => "98102"}
      }
      post :create, {"package": package_data}

      assert_match 'application/json', response.header['Content-Type']
      body = JSON.parse(response.body)

      assert_instance_of Array, body
    end
  end
