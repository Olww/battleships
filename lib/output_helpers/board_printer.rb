require_relative '../config'
require_relative 'game_interface'

class BoardPrinter
  SHIP_SYMBOL = 'S'
  WATER_SYMBOL = ' '
  HIT_SHIP_SYMBOL = 'X'
  HIT_WATER_SYMBOL = '•'

  include Config

  def initialize(board:)
    @board = board
  end

  def print_open
    print_board
  end

  def print_secret
    print_board(secret: true)
  end

  private

  attr_reader :board

  def game_interface
    @game_interface ||= GameInterface.instance
  end

  def print_board(secret: false)
    game_interface.puts row_numbers
    print_cells(secret: secret)
  end

  def print_cells(secret:)
    board.cells.each_with_index do |row, i|
      game_interface.print "#{row_letter(index: i)} |"

      row.each do |cell|
        game_interface.print print_cell(cell: cell, secret: secret) + "|"
      end

      game_interface.print "\n"
    end
  end

  def print_cell(cell:, secret: false)
    if cell.shot?
      cell.instance_of?(ShipCell) ? HIT_SHIP_SYMBOL : HIT_WATER_SYMBOL
    elsif secret
      " "
    else
      cell.instance_of?(ShipCell) ? SHIP_SYMBOL : WATER_SYMBOL
    end
  end

  def row_numbers
    "  |" + (1..config['dimensions']).to_a.join('|') + "|"
  end

  def row_letter(index:)
    (index + 'A'.ord).chr
  end
end
