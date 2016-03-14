class Board
  def initialize
    @board = Array.new(19)
    (0..@board.length - 1).each { |i|
      @board[i] = Array.new(19)
      (0..@board[i].length - 1).each { |j|
        if i == 0 or i == 18 or j == 0 or j == 18
          @board[i][j] = 'B'
        else
          @board[i][j] = '.'
        end
      }
    }
    @count = 0
    @moves = []
    @directionDic = {l: [-1, 0], r: [1, 0], u: [0, -1], b: [0, 1], ru: [1, -1], lb: [-1, 1], lu: [-1, -1], rb: [1, 1]}
  end

  def place(player, move)
    x = move.x
    y = move.y
    unless @board[y][x] == '.'
      return nil
    end
    @board[y][x] = player.symbol
    @moves.push(move)
    puts self
    puts "\n"
    move
  end

  def connection(move)
    x = move.x
    y = move.y
    symbol = @board[y][x]
    directions = Array.new(4)
    directions[0] = connectLength(x - 1, y, symbol, 'l') + 1 + connectLength(x + 1, y, symbol, 'r')
    directions[1] = connectLength(x, y - 1, symbol, 'u') + 1 + connectLength(x, y + 1, symbol, 'b')
    directions[2] = connectLength(x + 1, y - 1, symbol, 'ru') + 1 + connectLength(x - 1, y + 1, symbol, 'lb')
    directions[3] = connectLength(x - 1, y - 1, symbol, 'lu') + 1 + connectLength(x + 1, y + 1, symbol, 'rb')
    directions
  end

  def maxConnection(move)
    directions = connection(move)
    if directions
      directions.max
    end
  end

  def win?
    move = @moves.last
    unless move
      return false
    end
    maxConnection(move) >= 5
  end

  def draw?
    @count >= 17 * 17
  end

  def connectEnd(x, y, symbol, direction)
    xDir = @directionDic[direction.to_sym][0]
    yDir = @directionDic[direction.to_sym][1]
    xPos = x
    yPos = y
    loop do
      xPos += xDir
      yPos += yDir
      break if @board[yPos][xPos] != symbol
    end
    if @board[yPos][xPos] == '.'
      [xPos, yPos]
    else
      nil
    end
  end


  def connectLength(x, y, symbol, direction)
    if x < 0 or x > 16 or y < 0 or y > 16
      return 0
    end
    if @board[y][x] != symbol
      return 0
    end
    case direction
      when 'lu'
        return 1 + connectLength(x - 1, y - 1, symbol, direction)
      when 'l'
        return 1 + connectLength(x - 1, y, symbol, direction)
      when 'lb'
        return 1 + connectLength(x - 1, y + 1, symbol, direction)
      when 'b'
        return 1 + connectLength(x, y + 1, symbol, direction)
      when 'rb'
        return 1 + connectLength(x + 1, y + 1, symbol, direction)
      when 'r'
        return 1 + connectLength(x + 1, y, symbol, direction)
      when 'ru'
        return 1 + connectLength(x + 1, y - 1, symbol, direction)
      when 'u'
        return 1 + connectLength(x, y - 1, symbol, direction)
      else
        throw 'unknown direction'
    end
  end

  def move(pos)
    if pos == 'last'
      @moves.last
    elsif pos == 'first'
      @moves.first
    else
      @moves[pos]
    end
  end

  def empty?(x, y)
    @board[y][x] == '.'
  end

  def randEmptyPos
    loop do
      x = rand(17) + 1
      y = rand(17) + 1
      if empty?(x, y)
        return [x, y]
      end
    end
  end

  def to_s
    board_s = ''
    @board.each_index{
      |x|
      if x > 0 and x < @board.length - 1
        board_s += @board[x].slice(1 .. @board.length - 2).join(' ')
        board_s += "\n"
      end
    }
    board_s
  end
end

a = Board.new
puts a