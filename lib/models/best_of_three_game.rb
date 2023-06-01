# frozen_string_literal: true

require_relative '../models/game'

class BestOfThreeGame < Game
  def start
    initialize_game_state
    until best_of_3_finished
      start_game_loop
      prepare_new_game
    end
  end

  private

  def best_of_3_finished
    players.any? { |player| player.score == 2 }
  end
end
