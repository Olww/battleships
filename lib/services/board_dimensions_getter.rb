# frozen_string_literal: true

require_relative '../config'
require 'singleton'

class BoardDimensionsGetter
  include Config
  include Singleton
  def row_numbers
    "  |#{(1..config['dimensions']).to_a.join('|')}|"
  end

  def horizontal_coordinates_mapping
    (0..config['dimensions'] - 1).to_a.map { |i| row_letter(index: i) }.zip(0..4).to_h
  end

  def row_letter(index:)
    (index + 'A'.ord).chr
  end

  def coordinates_to_dimensions(coordinates:)
    row_letter(index: coordinates[0]) + (coordinates[1] + 1).to_s
  end
end
