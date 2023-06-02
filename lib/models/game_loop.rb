# frozen_string_literal: true

require_relative '../output_helpers/game_interface'
require_relative 'best_of_three_game'

class GameLoop
  attr_reader :game

  def initialize(game:)
    @game = game
  end

  def call
    start_game
  end

  private

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def start_game
    until game.game_finished
      game.change_turn
      make_turn
    end
  end

  def make_turn
    game.turn_printer.call
    start_turn_loop
  end

  def start_turn_loop
    loop do
      shot = game.current_player.make_turn
      status = game.current_enemy.receive_shot(shot)

      case status
      when :hit_before
        game_interface.hit_before_status_message
      when :hit
        game_interface.hit_status_message
        break
      when :miss
        game_interface.miss_status_message
        break
      when :sunk
        game_interface.sunk_status_message
        break
      when :win
        game_interface.win_status_message(game.current_player.name)
        game.current_player.add_score
        game.finish_game
        ask_for_rematch unless best_of_3_game?
        break
      end
    end
  end

  def ask_for_rematch
    game_interface.ask_for_rematch_message
    rematch = gets.chomp
    if rematch == 'y'
      game.prepare_new_game
      start_game
    else
      game_interface.goodbye_message
    end
  end

  def best_of_3_game?
    game.instance_of?(BestOfThreeGame)
  end
end
