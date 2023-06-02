# frozen_string_literal: true

require_relative '../models/game'

class BestOfThreeGame < Game
  def start
    initialize_game_state
    start_match_loop
    ask_for_rematch
  end

  def finish_game
    super
    game_interface.score_message(players)
  end

  private

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def start_match_loop
    loop do
      start_game_loop
      if best_of_3_finished?
        game_interface.best_of_3_finished_message(current_player.name)
        break
      end
      prepare_new_game
    end
  end

  def best_of_3_finished?
    players.any? { |player| player.score.zero? }
  end

  def ask_for_rematch
    game_interface.ask_for_rematch_message
    rematch = gets.chomp
    if rematch == 'y'
      prepare_new_game
      start_match_loop
    else
      game_interface.goodbye_message
    end
  end

  def clear_game_state
    super
    players.each(&:reset_score)
  end
end
