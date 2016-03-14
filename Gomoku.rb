require './Human'
require './Computer'
require './Board'

class Gomoku
  def initialize
    @board = Board.new
    @player1 = nil
    @player2 = nil
    @turn = nil
  end

  def startGame
    choosePlayerType
    play
  end

  def choosePlayerType
    until @player1 do
      puts 'Choose player 1 type [computer|human]: '
      p = gets.strip
      if p == 'computer'
        @player1 = Computer.new('O')
      elsif p == 'human'
        @player1 = Human.new('O')
      end
    end
    until @player2 do
      puts 'Choose player 2 type [computer|human]: '
      p = gets.strip
      if p == 'computer'
        @player2 = Computer.new('X')
      elsif p == 'human'
        @player2 = Human.new('X')
      end
    end
  end

  def play
    until @board.win? or @board.draw?
      changeTurn
      loop do
        break if @board.place(@turn, @turn.nextMove(@board))
      end
    end
    result
  end

  def result
    if @board.draw?
      puts 'Game over: Draw!'
    else
      puts 'Game over: ' + @turn.symbol + ' Win!'
    end
  end


  def changeTurn
    if @turn == @player1
      @turn = @player2
    elsif @turn == @player2
      @turn = @player1
    else
      @turn = @player1
    end
  end
end

game = Gomoku.new
game.startGame