require_relative '../input_helpers/input_helper'
require_relative '../models/board'


class Player
  attr_reader :name, :board

  def initialize
    @input_helper = InputHelper.new
    @name = input_helper.get_player_name
    @board = Board.new
  end

  private

  attr_reader :input_helper
end
