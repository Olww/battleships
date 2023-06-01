require_relative '../input_helpers/input_helper'
require_relative '../output_helpers/board_printer'
require_relative '../models/board'
require_relative '../services/ship_placement_handler'
require_relative '../services/ship_factory'

class Player
  attr_reader :name, :board

  def initialize
    @input_helper = InputHelper.new
    @name = input_helper.get_player_name
    # @name = "Test #{rand}"
    @board = Board.new
  end

  def initialize_ship(length)
    ShipPlacementHandler.new(board: board, length: length).place
  end

  def make_turn
    input_helper.get_turn_input
  end

  def receive_shot(coordinates)
    board.shoot_cell(coordinates)
  end

  def clear_board!
    @board = Board.new
  end

  private
  attr_reader :input_helper
end
