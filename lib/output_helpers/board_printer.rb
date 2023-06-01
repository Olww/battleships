# frozen_string_literal: true

require_relative 'game_interface'
require_relative '../services/board_dimensions_getter'

class BoardPrinter
  SHIP_SYMBOL = 'S'
  WATER_SYMBOL = ' '
  HIT_SHIP_SYMBOL = 'X'
  HIT_WATER_SYMBOL = '•'

  def initialize(board:)
    @board = board
    @board_dimensions_getter = BoardDimensionsGetter.instance
  end

  def print_open
    print_board
  end

  def print_secret
    print_board(secret: true)
  end

  private

  attr_reader :board, :board_dimensions_getter

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def print_board(secret: false)
    game_interface.puts board_dimensions_getter.row_numbers
    print_cells(secret: secret)
  end

  def print_cells(secret:)
    board.cells.each_with_index do |row, i|
      game_interface.print "#{board_dimensions_getter.row_letter(index: i)} |"

      row.each do |cell|
        game_interface.print "#{print_cell(cell: cell, secret: secret)}|"
      end

      game_interface.print "\n"
    end
  end

  def print_cell(cell:, secret: false)
    if cell.shot?
      cell.instance_of?(ShipCell) ? HIT_SHIP_SYMBOL : HIT_WATER_SYMBOL
    elsif secret
      ' '
    else
      cell.instance_of?(ShipCell) ? SHIP_SYMBOL : WATER_SYMBOL
    end
  end
end
