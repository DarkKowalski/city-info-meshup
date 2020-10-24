# frozen_string_literal: true

require 'bundler'
Bundler.require
require 'logger'
require 'json'

require_relative 'const'
Dir[File.dirname(__FILE__) + '/routes/*.rb'].sort.each { |file| require file }
Dir[File.dirname(__FILE__) + '/errors/*.rb'].sort.each { |file| require file }
Dir[File.dirname(__FILE__) + '/initializers/*.rb'].sort.each { |file| require file }
Dir[File.dirname(__FILE__) + '/models/*.rb'].sort.each { |file| require file }
Dir[File.dirname(__FILE__) + '/services/*.rb'].sort.each { |file| require file }
