[![Build Status](https://travis-ci.org/kyleboss/cabify_checkout.svg?branch=master)](https://travis-ci.org/kyleboss/cabify_checkout)
[![Maintainability](https://api.codeclimate.com/v1/badges/053a1c5e40457e29a902/maintainability)](https://codeclimate.com/repos/5a5e493d25d7c002850001af/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/053a1c5e40457e29a902/test_coverage)](https://codeclimate.com/repos/5a5e493d25d7c002850001af/test_coverage)

# CabifyCheckout.com

Checkout System for Cabify's international, physical stores. Has two pages: http://cabifycheckout.com and 
http://cabifycheckout.com/admin.

## Setup
1) `git clone https://github.com/kyleboss/cabify_checkout`
2) `cd cabify_checkout`
3) `yarn install`
4) `rake db:create`
5) `rake db:migrate`
6) `rake db:seed`
7) `bundle install`

### To run the server
1) `rails s`
2) Go to http://localhost:3000 or http://localhost:3000/admin for the admin panel.

### To run console application
1) `rails c`
2) `co = Checkout.new`
3) `co.scan("VOUCHER")`
4) `co.scan("VOUCHER")`
5) `co.scan("TSHIRT")`
6) `price = co.total`

## Specs
There are a lot of specs. If you care to add any, feel free to add some to the appropriate spec directory. Note there
are also Factories with FactoryBot (previously FactoryGirl), populated with the Faker gem. 
1) `rspec`


## Server Information
This project is set-up with Code Climate, Travis CI, & AWS Elastic Beanstalk. See config files for more information.