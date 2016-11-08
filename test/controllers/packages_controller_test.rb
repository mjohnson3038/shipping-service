require 'test_helper'
require 'active_shipping'

class PackagesControllerTest < ActionController::TestCase

  setup do
    @request.headers['Accept'] = Mime::JSON
    @request.headers['Content-Type'] = Mime::JSON.to_s
  end

  PACKAGE_KEYS = %w( weight state city zip )
  O_COUNTRY = "USA"
  O_STATE = "WA"
  O_CITY = "Seattle"
  O_ZIP = "98161"

  D_COUNTRY = "USA"

  SIZE_WIDTH = 12
  SIZE_HEIGHT = 15
  SIZE_LENGTH = 4.5

  test "find_rate should return an array of rate options" do
    get :find_rate
    p = packages(:one)
    puts "gdasgjdkljagslkjdgaslkjdgalsjkdglj #{p}"
    rates = p.find_rate
    assert_kind_of Array, rates
  end

  # test "can get #index" do
  #   get :index
  #   assert_response :success
  # end
  #
  # test "#index returns json" do
  #   get :index
  #   assert_match 'application/json', response.header['Content-Type']
  # end
  #
  # test "#index returns an Array of Package objects" do
  #   get :index
  #   # Assign the result of the response from the controller action
  #   body = JSON.parse(response.body)
  #   assert_instance_of Array, body
  # end
  #
  # test "returns three pet objects" do
  #   get :index
  #   body = JSON.parse(response.body)
  #   assert_equal 3, body.length
  # end
end
