class GameLoop
  attr_reader :game

  def initialize(game:)
    @game = game
  end

  def call; end
end
