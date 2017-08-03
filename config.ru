require 'rubygems'
require 'bundler/setup'
require "sinatra"

require File.expand_path '../ipsum.rb', __FILE__

run Ipsum
