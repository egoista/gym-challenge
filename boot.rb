# frozen_string_literal: true

# Load application

require_relative 'app/models/base_model/attributes_type.rb'

Dir['./app/**/*.rb'].each do |file|
  require file
end
