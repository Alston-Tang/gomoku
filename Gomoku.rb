require 'Human'
require 'Computer'

class Gomoku
  def initialize
    @board = Array.new(17, Array.new(17, '.'))
    @player1 = nil
    @player2 = nil
    @turn = nil
  end

  def startGame
    choosePlayerType
    @turn = @player1
    play
  end

  def choosePlayerType
    until @player1 do
      puts 'Choose player 1 type [computer|human]: '
      p = gets
      if p == 'computer'
          @player1 = Computer.new('O')
      elsif p == 'human'
          @player1 = Human.new('O')
      end
    end
    until @player2 do
      puts 'Choose player 2 type [computer|human]: '
      p = gets
      if p == 'computer'
        @player2 = Computer.new('O')
      elsif p == 'human'
        @player2 = Human.new('O')
      end
    end

    def play
      move = @turn.nextMove
    end

    def changeTurn
      if @turn == @player1
        @turn = @player2
      else
        @turn = @player1
      end
    end

    def win?(move)
      row = concatLength(x - 1, y, @turn)
    end

    def concatLength(x, y, symbol, direction)
      if x < 0 or x > 16 or y < 0 or y > 16
        return 0
      end
      if @board[y][x] != symbol
        return 0
      end
      case direction
        when 'lu'
          return 1 + concatLength(x - 1, y - 1, symbol, direction)
        when 'l'
          return 1 + concatLength(x - 1, y, symbol, direction)
        when 'lb'
          return 1 + concatLength(x - 1, y + 1, symbol, direction)
        when 'b'
          return 1 + concatLength(x, y + 1, symbol, direction)
        when 'rb'
          return 1 + concatLength(x + 1, y + 1, symbol, direction)
        when 'r'
          return 1 + concatLength(x + 1, y, symbol, direction)
        when 'ru'
          return 1 + concatLength(x + 1, y - 1, symbol, direction)
        when 'u'
          return 1 + concatLength(x, y - 1, symbol, direction)
      end
    end
  end

  def to_s
    p = ''
    @board.each{
      |x| p += x.join(' ')
      p += "\n"
    }
    p
  end
end



t = Gomoku.new