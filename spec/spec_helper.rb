# make all file visible inside fpr testing

Dir[File.join(__dir__, '../lib/**/*.rb')].each do |file|
  require_relative file
end

require 'pry'
