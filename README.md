# iTrack

[![Code Climate](https://codeclimate.com/github/gkuhn1/itrack/badges/gpa.svg)](https://codeclimate.com/github/gkuhn1/itrack)
[![CircleCI status](https://circleci.com/gh/gkuhn1/itrack/tree/master.svg?style=shield)](https://circleci.com/gh/gkuhn1/itrack)


This is a [Rails](http://rubyonrails.org/) application built to track user activity through pages.

## Dependências

To run this project you should install:

* Ruby 2.3.0 - You can use [RVM](http://rvm.io)

## Project Setup

1. Install dependencies:
2. `$ git clone --recursive https://github.com/gkuhn1/iTrack.git` - to clone the project
2.1 - If you have cloned without --recursive:
2.1.1 - `$ git submodule init` - to initialize submodules
2.1.2 - `$ git submodule update` -  to clone and install submodules
3. `$ cd iTrack` - Join on project folder
4. `$ bin/setup` - Execute setup script
5. `$ rspec` - Run specs to check if everything is ok

If everything is ok, now you can run server

## Run

1. `$ rails s` - Execute server
2. Open [http://localhost:3000](http://localhost:3000)
3. Default BasicAuthorization: admin:pwd

#### Running specs and checking coverage

`$ rake spec` To run specs

`$ coverage=on rake spec` To run specs and generate coverage report

## Acessing DemoWebsite to track access

1. Open [https://dev-itrack.herokuapp.com/website/](https://dev-itrack.herokuapp.com/website/)

## Acessing Demo iTrack

1. Open [https://dev-itrack.herokuapp.com/](https://dev-itrack.herokuapp.com/)
2. Basic Login: admin
3. Basic password: pwd
