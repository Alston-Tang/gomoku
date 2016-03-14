class Player
  def initialize(symbol)
    @symbol = symbol
  end
  def symbol
    @symbol
  end
  def nextMove(board)

  end
  def win
    puts @symbol + ' win!'
  end
end