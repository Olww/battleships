# frozen_string_literal: true

class Ship
  def initialize(length:, start_coordinate:, end_coordinate:)
    @start_coordinate = start_coordinate
    @end_coordinate = end_coordinate
    @length = length
    @hit_points = length
    verify_coordinates_position
  end

  def self.create_drone_boat(start_coordinate:, end_coordinate:)
    new(length: 1, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
  end

  def self.create_patrol_boat(start_coordinate:, end_coordinate:)
    new(length: 2, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
  end

  def self.create_submarine(start_coordinate:, end_coordinate:)
    new(length: 3, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
  end

  def self.create_destroyer(start_coordinate:, end_coordinate:)
    new(length: 4, start_coordinate: start_coordinate, end_coordinate: end_coordinate)
  end

  def get_coordinates
    cells = []

    if horizontal?
      length.times do |i|
        cells << [start_row, start_column + i]
      end
    elsif vertical?
      length.times do |i|
        cells << [start_row + i, start_column]
      end
    elsif diagonal?
      if start_row < end_row
        length.times do |i|
          cells << [start_row + i, start_column + i]
        end
      else
        length.times do |i|
          cells << [start_row - i, start_column + i]
        end
      end
    end

    cells
  end

  def valid?
    if horizontal?
      end_column - start_column + 1 == length
    elsif vertical?
      end_row - start_row + 1 == length
    elsif diagonal?
      (end_row - start_row).abs + 1 == length && (end_column - start_column).abs + 1 == length
    else
      false
    end
  end

  def take_hit
    @hit_points -= 1
  end

  def sunk?
    hit_points.zero?
  end

  private

  attr_reader :start_coordinate, :end_coordinate, :length, :hit_points

  def end_column
    end_coordinate[1]
  end

  def end_row
    end_coordinate[0]
  end

  def start_column
    start_coordinate[1]
  end

  def start_row
    start_coordinate[0]
  end

  def verify_coordinates_position
    if start_coordinate[0] <= end_coordinate[0] && start_coordinate[1] <= end_coordinate[1]
      @start_coordinate = end_coordinate
      @end_coordinate = start_coordinate
    end
  end

  def horizontal?
    start_row == end_row
  end

  def vertical?
    start_column == end_column
  end

  def diagonal?
    (end_row - start_row).abs == (end_column - start_column).abs
  end
end
