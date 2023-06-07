# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HintObserver do
  let(:game_interface) { instance_double('GameInterface') }
  let(:board_dimensions_getter) { instance_double('BoardDimensionsGetter') }
  let(:hint_observer) { HintObserver.new }

  before do
    allow(GameInterface).to receive(:instance).and_return(game_interface)
    allow(BoardDimensionsGetter).to receive(:instance).and_return(board_dimensions_getter)
  end

  describe '#update' do
    context 'when status is :miss' do
      context 'and it is time to give a hint' do
        it 'gives a hint and resets the before_hint_counter' do
          hint = [2, 2]
          transformed_hint = 'C3'
          allow(board_dimensions_getter).to receive(:coordinates_to_dimensions).and_return(transformed_hint)

          expect(game_interface).to receive(:hint_message).with(transformed_hint)
          hint_observer.update(hint, :miss)
          hint_observer.update(hint, :miss)
          hint_observer.update(hint, :miss)
          hint_observer.update(hint, :hit)

          expect(hint_observer.instance_variable_get(:@before_hint_counter)).to eq(0)
        end
      end

      context 'and it is not time to give a hint' do
        it 'increments the before_hint_counter' do
          hint_observer.instance_variable_set(:@before_hint_counter, 1)

          hint_observer.update([2, 2], :miss)

          expect(hint_observer.instance_variable_get(:@before_hint_counter)).to eq(2)
        end
      end
    end

    context 'when status is not :miss' do
      it 'resets the before_hint_counter' do
        hint_observer.instance_variable_set(:@before_hint_counter, 2)

        hint_observer.update([2, 2], :hit)

        expect(hint_observer.instance_variable_get(:@before_hint_counter)).to eq(0)
      end
    end
  end
end
