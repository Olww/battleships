# frozen_string_literal: true

require_relative '../output_helpers/game_interface'
require_relative '../config'

class GameInitializer
  attr_reader :game

  include Config

  def initialize(game:)
    @game = game
  end

  def initialize_players
    config['number_of_players'].times do |i|
      game_interface.player_creation_message(i)
      game.add_player(Player.new)
    end
    shuffle_players
  end

  def initialize_ships
    game.players.each { |player| place_ships(player) }
  end

  private

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def place_ships(player)
    game_interface.player_ship_placement(player.name)

    config['ships'].each do |length|
      player.initialize_ship(length)
    end

    player.board.board_printer.print_open
    game_interface.wait_to_continue
  end

  def shuffle_players
    game.players.shuffle!
  end
end
