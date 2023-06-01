require_relative '../input_helpers/input_helper'
require_relative '../models/board'
require_relative '../services/ship_placement_handler'


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

  private

  attr_reader :input_helper
end
