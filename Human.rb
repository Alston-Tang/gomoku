require './Player'
require './Move'
class Human < Player
  def initialize(symbol)
    super(symbol)
  end
  def nextMove(board)
    puts 'Input your next move: [row] [column]'
    move = gets.split(' ').map! { |x| x.to_i}
    Move.new(move[0], move[1], self)
  end
end