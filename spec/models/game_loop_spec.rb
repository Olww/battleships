require 'spec_helper'

RSpec.describe GameLoop do
  let(:game) { instance_double(Game) }

  subject(:game_loop) { described_class.new(game: game) }

  describe '#call' do
    it 'starts the game loop' do
      game_loop.call
    end
  end
end
