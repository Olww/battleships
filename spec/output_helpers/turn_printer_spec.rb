# frozen_string_literal: true

require_relative '../../lib/output_helpers/turn_printer'
require_relative '../../lib/output_helpers/game_interface'
require_relative '../../lib/models/player'
require_relative '../../lib/models/board'
require_relative '../../lib/models/game'
require_relative '../../lib/output_helpers/board_printer'

RSpec.describe TurnPrinter do
  let(:game_interface) { instance_double(GameInterface, clear_screen: true) }
  let(:player1) { instance_double(Player, name: 'Player 1', board: board) }
  let(:player2) { instance_double(Player, name: 'Player 2', board: board) }
  let(:board) { instance_double(Board, board_printer: board_printer) }
  let(:board_printer) { instance_double(BoardPrinter) }
  let(:game) { instance_double(Game, players: [player1, player2]) }

  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game_interface).to receive(:puts)
    allow(game_interface).to receive(:print)
  end

  subject(:turn_printer) { described_class.new(game: game) }

  describe '#call' do
    before do
      allow(turn_printer).to receive(:gets)
      allow(board_printer).to receive(:print_open)
      allow(board_printer).to receive(:print_secret)
    end

    it 'prints header and boards' do
      expect(turn_printer).to receive(:print_header)
      expect(turn_printer).to receive(:print_boards)
      turn_printer.call
    end

    it 'interacts with game_interface' do
      turn_printer.call
      expect(game_interface).to have_received(:puts).at_least(:once)
    end

    it 'calls methods on board_printer' do
      turn_printer.call
      expect(board_printer).to have_received(:print_open)
      expect(board_printer).to have_received(:print_secret)
    end
  end
end
