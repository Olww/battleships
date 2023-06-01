# frozen_string_literal: true

require_relative '../models/ship'

class ShipFactory
  def self.build_ship(length:, start_coordinate:, end_coordinate:)
    case length
    when 1
      Ship.create_drone_boat(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
    when 2
      Ship.create_patrol_boat(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
    when 3
      Ship.create_submarine(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
    when 4
      Ship.create_destroyer(start_coordinate: start_coordinate, end_coordinate: end_coordinate)
    else
      raise ArgumentError, "Invalid ship length: #{length}"
    end
  end
end
