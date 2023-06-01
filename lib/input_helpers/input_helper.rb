# frozen_string_literal: true

class InputHelper
  def initialize
    @board_dimensions_getter = BoardDimensionsGetter.instance
  end

  def get_player_name
    game_interface.name_entrance_message
    gets.chomp
  end

  def get_battleship_coordinates
    game_interface.enter_coordinates_message('start')
    start_coordinate = enter_coordinate
    game_interface.enter_coordinates_message('end')
    end_coordinate = enter_coordinate

    { start_coordinate: start_coordinate, end_coordinate: end_coordinate }
  end

  def get_turn_input
    game_interface.enter_coordinates_message('shot')
    enter_coordinate
  end

  private

  attr_reader :board_dimensions_getter

  def horizontal_coordinates_mapping
    @horizontal_coordinates_mapping ||= board_dimensions_getter.horizontal_coordinates_mapping
  end

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def enter_coordinate
    while (input = gets.chomp.upcase)
      input = transform_coordinate_input(input)
      break if correct_coordinate?(input)

      game_interface.incorrect_input_message
    end

    input
  end

  def transform_coordinate_input(input)
    [horizontal_coordinates_mapping[input[0]], input[1].to_i - 1]
  end

  def correct_coordinate?(input)
    input.length == 2 && horizontal_coordinates_mapping.value?(input[0]) && horizontal_coordinates_mapping.value?(input[1])
  end
end
