class Move
  def initialize(x, y, player)
    @xPos = x
    @yPos = y
    @player = player
  end
  def x
    @xPos
  end
  def y
    @yPos
  end
  def player
    @player
  end
end