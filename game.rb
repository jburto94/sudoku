require_relative 'board'

class Game
  def initialize
    @board = Board.new
    @solved = @board.solved?
  end

  def valid_tile?(pos)
    if !(pos[0].to_s =~ /\A[-+]?\d*\.?\d+\z/) || !(pos[1].to_s =~ /\A[-+]?\d*\.?\d+\z/)
      return false
    end
    return false if pos[0] > 8 || pos[1] > 8 || pos[0] < 0 || pos[1] < 0
    return false if @board.grid[pos[0]][pos[1]].given
    return true
  end

  def get_tile
    p "Please enter the position of the tile you would like to edit (e.g., '3,1')"
    pos = gets.chomp.split(",").map { |num| num.to_i }
    while !valid_tile?(pos)
      p "Please enter the position of the tile you would like to edit (e.g., '3,1')"
      pos = gets.chomp.split(",").map { |num| num.to_i }
    end
    return pos
  end

  def valid_value?(val)
    return false if val.to_s =~ /\A[-+]?\d*\.?\d+\z/
    return false if val > 9 || val < 1
    return true
  end

  def get_value
    p "Please enter the value you would like the tile to be (1-9)"
    value = gets.chomp.to_i
    while valid_value?(value)
      p "Please enter the value you would like the tile to be (1-9)"
      value = gets.chomp
    end

    return value.to_s
  end

  def play
    while @solved == false
      @board.print_board
      tile = self.get_tile
      value = self.get_value
      @board.update_tile(tile, value)
      @solved = @board.solved?
    end
    @board.print_board
    p "Congratulations! You have beaten the game!"
  end
end

if $PROGRAM_NAME == __FILE__
  game = Game.new

  game.play
end