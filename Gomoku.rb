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
      puts 'First player is (1) Computer or (2) Human?'
      p = gets.to_i
      if p == 1
        @player1 = Computer.new('O')
      elsif p == 2
        @player1 = Human.new('O')
      end
    end
    until @player2 do
      puts 'Second player is (1) Computer or (2) Human?'
      p = gets.to_i
      if p == 1
        @player2 = Computer.new('X')
      elsif p == 2
        @player2 = Human.new('X')
      end
    end
  end

  def play
    until @board.win? or @board.draw?
      changeTurn
      loop do
        puts @board
        break if @board.place(@turn, @turn.nextMove(@board))
      end
    end
    result
  end

  def result
    puts @board
    if @board.draw?
      puts 'Draw!'
    else
      puts 'Player ' + @turn.symbol + ' wins!'
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