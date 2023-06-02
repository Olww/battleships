# frozen_string_literal: true

require_relative 'game_interface'

class TurnPrinter
  attr_accessor :game

  def initialize(game:)
    @game = game
  end

  def call
    print_header
    print_boards
  end

  private

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def print_header
    game_interface.clear_screen
    game_interface.puts '***************************************'
    game_interface.puts "* Player #{current_player.name} Turn! *\n\n"
    game_interface.puts 'Press enter when you ready to shoot!'
    gets
  end

  def print_boards
    game_interface.puts '********** Your board state ***********'

    current_player.board.board_printer.print_open
    game_interface.puts '***************************************'
    game_interface.puts '********** Enemy board state **********'

    current_enemy.board.board_printer.print_secret

    game_interface.puts "***************************************\n\n"
  end

  def current_player
    game.players[0]
  end

  def current_enemy
    game.players[1]
  end
end
