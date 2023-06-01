require_relative '../input_helpers/input_helper'
require_relative '../output_helpers/game_interface'

class ShipPlacementHandler
  def initialize(board:, length:)
    @input_helper = InputHelper.new
    @board = board
    @length = length
  end

  def place
    loop do
      print_placement_tip

      ship = ShipFactory.build_ship(**ship_params(length))

      unless ship.valid? && valid_ship_place?(ship)
        game_interface.ship_placement_error_message
        next
      end

      place_ship_on_board(ship)
      break
    end
  end

  private

  attr_reader :board, :length, :input_helper

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def print_placement_tip
    game_interface.ship_placement_message(length)
    board.board_printer.print_open
  end

  def place_ship_on_board(ship)
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