# frozen_string_literal: true

require_relative '../input_helpers/input_helper'
require_relative '../output_helpers/game_interface'
require_relative '../models/ship'

class ShipPlacementHandler
  def initialize(board:, length:)
    @input_helper = InputHelper.new
    @board = board
    @length = length
  end

  def place
    loop do
      game_interface.ship_placement_message(length)
      board.board_printer.print_open
      ship = Ship.new(**ship_params(length))

      unless ship.valid? && valid_ship_place?(ship)
        game_interface.ship_placement_error_message
        next
      end

      add_ship_on_board(ship)
      break
    end
  end

  private

  attr_reader :board, :length, :input_helper

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def add_ship_on_board(ship)
    board.add_ship(ship)
    ship.get_coordinates.each { |coordinates| board.occupy_cell(coordinates) }
  end

  def valid_ship_place?(ship)
    ship.get_coordinates.none? { |coordinates| board.cell_occupied?(coordinates) }
  end

  def ship_params(length)
    ship_coordinates = input_helper.get_battleship_coordinates

    { length: length, start_coordinate: ship_coordinates[:start_coordinate], end_coordinate: ship_coordinates[:end_coordinate] }
  end
end
