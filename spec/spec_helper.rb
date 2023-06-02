# frozen_string_literal: true

# make all file visible inside rspec tests

Dir[File.join(__dir__, '../lib/**/*.rb')].sort.each do |file|
  require_relative file
end

require 'stringio'
require 'singleton'
