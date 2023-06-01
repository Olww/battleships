class GameLoop
  attr_reader :game

  def initialize(game:)
    @game = game
  end

  def call
    game_interface.goodbye_message
    exit
  end

  private

  def game_interface
    @game_interface ||= GameInterface.instance
  end
end
