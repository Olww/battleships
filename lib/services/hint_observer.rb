# frozen_string_literal: true

class HintObserver
  def initialize
    @game_interface = GameInterface.instance
    @board_dimensions_getter = BoardDimensionsGetter.instance
    @before_hint_counter = 0
  end

  def update(hint, status)
    if status == :miss
      give_hint? ? give_hint(hint) : @before_hint_counter += 1
    else
      reset_before_hint_counter
    end
  end

  private

  attr_reader :board, :before_hint_counter

  def give_hint?
    before_hint_counter == 2
  end

  def give_hint(hint)
    transformed_hint = @board_dimensions_getter.coordinates_to_dimensions(coordinates: hint)
    @game_interface.hint_message(transformed_hint)
  end

  def reset_before_hint_counter
    @before_hint_counter = 0
  end
end
