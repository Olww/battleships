require 'spec_helper'

RSpec.describe BoardPrinter do
  let(:game_interface) { instance_double(GameInterface) }
  let(:board) { instance_double(Board, cells: cells) }
  let(:cells) { [[cell, ship_cell], [cell, ship_cell]] }
  let(:cell) { instance_double(Cell, shot?: false) }
  let(:ship_cell) { instance_double(ShipCell, shot?: false) }
  let(:board_printer) { BoardPrinter.new(board: board) }

  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(game_interface).to receive(:puts)
    allow(game_interface).to receive(:print)
    allow(board_printer).to receive(:config).and_return({ 'dimensions' => 2 })
  end

  describe "#print_open" do
    it "prints an open board" do
      expect(game_interface).to receive(:puts).with("  |1|2|")
      expect(game_interface).to receive(:print).exactly(8).times
      board_printer.print_open
    end
  end

  describe "#print_secret" do
    it "prints a secret board" do
      expect(game_interface).to receive(:puts).with("  |1|2|")
      expect(game_interface).to receive(:print).exactly(8).times
      board_printer.print_secret
    end
  end

  describe '#row_numbers' do
    it 'returns a string with row numbers' do
      expect(board_printer.send(:row_numbers)).to eq("  |1|2|")
    end
  end

  describe '#row_letter' do
    it 'returns the corresponding letter for the row index' do
      expect(board_printer.send(:row_letter, index: 0)).to eq('A')
      expect(board_printer.send(:row_letter, index: 1)).to eq('B')
      expect(board_printer.send(:row_letter, index: 25)).to eq('Z')
    end
  end
end
