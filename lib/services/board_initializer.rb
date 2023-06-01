class BoardInitializer
  def call
    board = Board.new
    add_hint_observer_to_board(board)
    board
  end

  private

  def add_hint_observer_to_board(board)
    board.add_hint_observer(HintObserver.new)
  end
end