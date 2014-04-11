require "lumiere/version"
require 'open-uri'
require 'net/http'
require 'pry'
require 'json'
require_relative 'provider'
Dir[File.dirname(__FILE__) + '/provider/*.rb'].each {|file| require file }
