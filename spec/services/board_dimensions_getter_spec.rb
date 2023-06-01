# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BoardDimensionsGetter do
  let(:config) { { 'dimensions' => 5 } }
  let(:board_dimensions_getter) { BoardDimensionsGetter.instance }

  before do
    allow(BoardDimensionsGetter.instance).to receive(:config).and_return(config)
  end

  describe '#row_numbers' do
    it 'returns a string with row numbers based on dimensions' do
      expect(board_dimensions_getter.row_numbers).to eq('  |1|2|3|4|5|')
    end
  end

  describe '#horizontal_coordinates_mapping' do
    it 'returns a hash with mappings from letters to indexes based on dimensions' do
      expected_hash = { 'A' => 0, 'B' => 1, 'C' => 2, 'D' => 3, 'E' => 4 }
      expect(board_dimensions_getter.horizontal_coordinates_mapping).to eq(expected_hash)
    end
  end

  describe '#row_letter' do
    it 'returns the corresponding letter for the provided index' do
      expect(board_dimensions_getter.row_letter(index: 0)).to eq('A')
      expect(board_dimensions_getter.row_letter(index: 1)).to eq('B')
      expect(board_dimensions_getter.row_letter(index: 4)).to eq('E')
    end
  end
end
