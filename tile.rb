require 'colorize'

class Tile
  attr_reader :given
  attr_accessor :value

  def initialize(value)
    @value = value
    @given = value != "0"
  end

  def to_s
    @given ? @value.to_s.colorize(:red) :
      @value != "0" ? @value : " "
  end
end