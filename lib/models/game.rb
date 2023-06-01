# frozen_string_literal: true

require_relative 'player'
require_relative 'game_loop'
require_relative '../output_helpers/turn_printer'
require_relative '../services/game_initializer'
require_relative '../config'

class Game
  attr_reader :players, :turn_printer, :game_finished, :game_loop

  include Config

  def initialize
    @turn_printer = TurnPrinter.new(game: self)
    @game_loop = GameLoop.new(game: self)
    @players = []
    @game_finished = false
  end

  def start
    initialize_game_state
    start_game_loop
  end

  def add_player(player)
    players << player
  end

  def change_turn
    players.rotate!
  end

  def current_player
    players[0]
  end

  def current_enemy
    players[1]
  end

  def finish_game
    @game_finished = true
  end

  private

  def game_initializer
    @game_initializer ||= GameInitializer.new(game: self)
  end

  def start_game_loop
    game_loop.call
  end

  def initialize_game_state
    game_initializer.initialize_players
    game_initializer.initialize_ships
  end
end
