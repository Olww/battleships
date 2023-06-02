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
    players.any? { |player| player.score == 2 }
  end

  def ask_for_rematch
    game_interface.ask_for_rematch_message
    rematch = gets.chomp
    if rematch == 'y'
      prepare_new_match
      start_match_loop
    else
      game_interface.goodbye_message
    end
  end

  def prepare_new_match
    prepare_new_game
    players.each(&:reset_score)
  end
end
