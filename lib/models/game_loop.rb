require_relative '../output_helpers/game_interface'

class GameLoop
  attr_reader :game

  def initialize(game:)
    @game = game
  end

  def call
    start_game
    game_interface.goodbye_message
    exit
  end

  private

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def start_game
    until game.game_finished do
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
        game.finish_game
        break
      end
    end
  end
end
