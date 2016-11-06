# Shipping Service API
Build a stand-alone shipping service API that calculates estimated shipping costs. Then, implement your shipping service API into the provided bEtsy application, Petsy.

## Learning Goals
- Develop the ability to read 3rd party code
- APIs
    - Design
    - Build
    - Test
- Continue working with JSON
- Revisit
    - HTTP interactions
    - Testing of 3rd party services
- Increased confidence in working with 3rd party APIs

## Guidelines
- Practice TDD to lead the development process for Models and Controllers
- Create user stories and keep the stories up-to-date throughout the project
- Have two Heroku deployments, Petsy and Shipping API
- Shipping API will communicate with Petsy via JSON
- Integrate the [ActiveShipping](https://github.com/Shopify/active_shipping) gem to do shipping-specific logic for you

## Project Baseline
Setup both rails applications before building and implementing your shipping API. One rails app will be the provided Betsy project, Petsy. The other will be from scratch, for your Shipping API. 

### Baseline Requirements
- A new Rails 4.2.7 application for your API
    - A Ruby gemset that locks the Ruby version to 2.3.1
    - Use [simplecov](https://github.com/colszowka/simplecov) for code coverage reporting
- Create a NEW fork from [Petsy](https://github.com/Ada-C6/betsy-shipping)
    - Host your forked Petsy app on Heroku
    - Review Petsy code to come up with a basic understanding of the current checkout user flow

## Project Expectations
Your API should generate a quote with options of shipping services and their cost by different carriers. The quote will be based on given addresses and a set of packages. Then, implement your API into Petsy.

### Technical Requirements
#### Your API will:
- Respond with JSON and meaningful HTTP response codes  
- Allow Users to get shipping cost quotes for different delivery types (standard, express, overnight, etc.)
- Allow Users to get a cost comparison of two or more carriers  
- Log all requests and their associated responses such that an audit could be conducted  
- Have appropriate error handling:
  - When a User's request is incomplete, return an appropriate error
  - When a User's request does not process in a timely manner, return an appropriate error

#### Your Petsy application will:
- Integrate shipping estimates into the checkout workflow using your shipping API
- Present the relevant shipping information to the user during the checkout process
  - Cost
  - Delivery estimate
  - Tracking information (when available)

### Testing
- 95% test coverage for all API Controller actions, Model validations, and Model methods

### Added Fun!
- Allow merchants to view the total shipping costs for all of their products in a particular order
- Find the seam in Petsy between the shopping and payment processing, and build a payment processing service
