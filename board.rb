require_relative 'tile'

class Board
  attr_accessor :grid

  def from_file
    file = File.open('./puzzles/sudoku2.txt')
    values = file.readlines.map { |line| line.chomp.split('') }
    grid = Array.new(9) { Array.new }
    values.each_with_index do |row, index|
      row.each do |value|
        grid[index] << Tile.new(value)
      end
    end

    grid
  end

  def initialize
    @grid = self.from_file
  end

  def print_board
    @grid.each do |row|
      row.each do |tile|
        
        print " #{tile.to_s}"
      end
      print "\n"
    end
  end

  def update_tile(pos, val)
    @grid[pos[0]][pos[1]].value = val
    p @grid[pos[0]][pos[1]]
  end

  def check_rows
    @grid.each do |row|
      tiles = Hash.new(0)
      row.each do |tile|
        tiles[tile.value] += 1
      end
      return false if !tiles.values.all? { |value| value == 1 }
      return false if tiles["0"] > 0
    end
    return true
  end

  def check_columns
    (0...9).each do |col|
      tiles = Hash.new(0)
      (0...9).each do |row|
        tile = @grid[row][col]
        tiles[tile.value] += 1
      end
      return false if !tiles.values.all? { |value| value == 1 }
      return false if tiles["0"] > 0
    end
    return true
  end

  def check_square(row_start, col_start)
    square = Hash.new(0)
    row_end = row_start + 2
    col_end = col_start + 2
    (row_start..row_end).each do |row|
      (col_start..col_end).each do |col|
        tile = @grid[row][col]
        square[tile.value] += 1
      end
    end
    square.values.all? { |value| value == 1 }
  end

  def check_all_squares
    row_start = 0
    col_start = 0

    while row_start < 7
      while col_start < 7
        return false if !self.check_square(row_start, col_start)
        col_start += 3
      end
      col_start = 0
      row_start += 3
    end

    return true
  end

  def solved?
    self.check_rows && self.check_columns && self.check_all_squares
  end
end