require 'active_shipping'

class PackagesController < ApplicationController
  PACKAGE_KEYS = %w( weight state city zip )
  O_COUNTRY = "USA"
  O_STATE = "WA"
  O_CITY = "Seattle"
  O_ZIP = "98161"

  D_COUNTRY = "USA"

  SIZE_WIDTH = 12
  SIZE_HEIGHT = 15
  SIZE_LENGTH = 4.5
  #
  # def index
  #   packages = Package.all
  #   render json: packages
  # end

  def find_rate
    packages = [
      ActiveShipping::Package.new(weight, [SIZE_LENGTH, SIZE_HEIGHT, SIZE_WIDTH], units: :imperial)
    ]

    origin = ActiveShipping::Location.new(country: O_COUNTRY, state: 'WA', city: 'Seattle', postal_code: '98102')

    destination = ActiveShipping::Location.new(country: D_COUNTRY, state: state, city: city, postal_code: zip)

    # Find out how much it'll be.
    # ups = ActiveShipping::UPS.new(login: ENV[ACTIVESHIPPING_UPS_LOGIN], password: ENV[ACTIVESHIPPING_UPS_PASSWORD], key: ENV[ACTIVESHIPPING_UPS_KEY])
    usps = ActiveShipping::USPS.new(login: ENV[ACTIVESHIPPING_USPS_LOGIN])

    response = ups.find_rates(origin, destination, packages)
    ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    response = usps.find_rates(origin, destination, packages)
    usps_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}

    final_array = ups_rates + usps_rates
    return final_array
  end
end
