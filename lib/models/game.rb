require_relative 'game_loop'
require_relative '../services/game_initializer'
require_relative '../config'

class Game
  attr_reader :players, :game_loop

  include Config

  def initialize
    @game_loop = GameLoop.new(game: self)
    @players = []
  end

  def start
    initialize_game_state
    start_game_loop
  end

  def add_player(player)
    players << player
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
