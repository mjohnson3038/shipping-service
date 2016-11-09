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
  UPS_LOGIN = ENV['ACTIVESHIPPING_UPS_LOGIN']
  PASSWORD = ENV['ACTIVESHIPPING_UPS_PASSWORD']
  KEY = ENV['ACTIVESHIPPING_UPS_KEY']
  USPS_LOGIN = ENV['ACTIVESHIPPING_USPS_LOGIN']



  def find_rate
    packages = [
      # ActiveShipping::Package.new(params[:weight].to_i, [SIZE_LENGTH, SIZE_HEIGHT, SIZE_WIDTH], units: :imperial)
      ActiveShipping::Package.new(60, [SIZE_LENGTH, SIZE_HEIGHT, SIZE_WIDTH], units: :imperial)
    ]
    # destination = ActiveShipping::Location.new(country: D_COUNTRY, state: params[:state],
    # city: params[:city], postal_code: params[:postal_code].to_i)
    destination = ActiveShipping::Location.new(country: D_COUNTRY, state: 'WA', city: 'Seattle', postal_code: '98118')

    usps_rates = get_usps_rates(ORIGIN, destination, packages)
    ups_rates = get_usp_rates(ORIGIN, destination, packages)

    response = {"ups" => ups_rates, "usps" => usps_rates}

    render json: response
  end

  def get_usps_rates(origin, destination, packages)
    usps = ActiveShipping::USPS.new(login: USPS_LOGIN)
    response = usps.find_rates(ORIGIN, destination, packages)
    rates =[]
    response.rates.each do |rate|
      usps_rate = {}
      usps_rate[:name] = rate.service_name
      usps_rate[:cost] = ((rate.total_price.to_f)/100)
      if !(rate.delivery_range.empty?)
        usps_rate[:delivery] = rate.delivery_range
      end
      rates << usps_rate
    end
    return rates
  end


  def get_usp_rates(origin, destination, packages)
    ups = ActiveShipping::UPS.new(login: UPS_LOGIN,
    password: PASSWORD, key: KEY)
    response = ups.find_rates(ORIGIN, destination, packages)
    @package_rates =[]
    response.rates.each do |rate|
      ups_rate = {}
      ups_rate[:name] = rate.service_name
      ups_rate[:cost] = ((rate.total_price.to_f)/100)
      if !(rate.delivery_range.empty?)
        ups_rate[:delivery] = rate.delivery_range
      end
      @package_rates << ups_rate
    end
    return @package_rates
  end
end
