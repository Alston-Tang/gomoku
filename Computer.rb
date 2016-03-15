require './Player'
require './Move'

class Computer < Player
  def initialize(symbol)
    super(symbol)
    puts "Player #{symbol} is Computer"
    @weakPoints = []
  end

  def findWeakPoints(board)
    lastMove = board.move('last')
    unless lastMove
      return nil
    end
    directions = board.connection(lastMove)
    x = lastMove.x
    y = lastMove.y
    symbol = lastMove.player.symbol

    pos1 = pos2 = nil
    if directions[0] == 4
      pos1 = board.connectEnd(x, y, symbol, 'l')
      pos2 = board.connectEnd(x, y, symbol, 'r')
    elsif directions[1] == 4
      pos1 = board.connectEnd(x, y, symbol, 'u')
      pos2 = board.connectEnd(x, y, symbol, 'b')
    elsif directions[2] == 4
      pos1 = board.connectEnd(x, y, symbol, 'lb')
      pos2 = board.connectEnd(x, y, symbol, 'ru')
    elsif directions[3] == 4
      pos1 = board.connectEnd(x, y, symbol, 'lu')
      pos2 = board.connectEnd(x, y, symbol, 'rb')
    end

    if pos1
      @weakPoints.push(pos1)
    end
    if pos2
      @weakPoints.push(pos2)
    end
  end

  def nextMove(board)
    findWeakPoints(board)
    if not @weakPoints.empty?
      pos = @weakPoints.pop
      Move.new(pos[0], pos[1], self)
    else
      pos = board.randEmptyPos
      Move.new(pos[0], pos[1], self)
    end
  end
end