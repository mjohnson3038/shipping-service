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
  ORIGIN = ActiveShipping::Location.new(country: O_COUNTRY, state: 'WA', city: 'Seattle', postal_code: '98102')
  LOGIN = ENV['ACTIVESHIPPING_UPS_LOGIN']
  PASSWORD = ENV['ACTIVESHIPPING_UPS_PASSWORD']
  KEY = ENV['ACTIVESHIPPING_UPS_KEY']


  def find_rate
    packages = [
      # ActiveShipping::Package.new(params[:weight].to_i, [SIZE_LENGTH, SIZE_HEIGHT, SIZE_WIDTH], units: :imperial)
      ActiveShipping::Package.new(60, [SIZE_LENGTH, SIZE_HEIGHT, SIZE_WIDTH], units: :imperial)
    ]
    # destination = ActiveShipping::Location.new(country: D_COUNTRY, state: params[:state],
    # city: params[:city], postal_code: params[:postal_code].to_i)
    destination = ActiveShipping::Location.new(country: D_COUNTRY, state: 'WA', city: 'Seattle', postal_code: '98118')

    # usps_rates = get_usps_rates(origin, destination, packages)
    ups_rates = get_usp_rates(ORIGIN, destination, packages)

    # response = {"usps" => usps_rates, "ups" => ups_rates}
    response = {"ups" => ups_rates}

    render json: response
  end

  # def get_usps_rates(origin, destination, packages)
  #   usps = ActiveShipping::USPS.new(login: ENV["ACTIVESHIPPING_USPS_LOGIN"])
  #   response = usps.find_rates(origin, destination, packages)
  #
  #   usps_rates = {}
  #   usps_rates = response.rates.sort_by(&:price).each do |rate|
  #     usps_rates[rate.service_name] =  rate.price
  #   end
  #   return usps_rates
  # end

  def get_usp_rates(origin, destination, packages)
    ups = ActiveShipping::UPS.new(login: LOGIN,
    password: PASSWORD, key: KEY)
    response = ups.find_rates(ORIGIN, destination, packages)

    ups_rates = {}
    ups_rates = response.rates.sort_by(&:price).each do |rate|
      ups_rates[rate.service_name] = rate.price
    end
    return ups_rates
  end
end
