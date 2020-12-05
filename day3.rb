# frozen_string_literal: true

class Location
  attr_reader :right, :down, :char

  def initialize(right:, down:, char: '.')
    @right = right
    @down = down
    @char = char
  end

  def tree?
    @char.match?(/#/)
  end
end

class Grid
  attr_reader :raw, :height, :width, :locations

  def initialize
    @raw = File.read('day3.txt').split("\n").map(&:chars)
    @height = @raw.size
    @width = @raw.first.size

    @locations = @raw.map.with_index do |row, down|
      row.map.with_index do |char, right|
        Location.new(
          right: right,
          down: down,
          char: char
        )
      end
    end
  end

  def location(right:, down:)
    return if down > @height

    @locations[down][right % @width]
  end
end

class Slope
  def self.d3p1
    Slope.new(right: 3, down: 1).trees.size
  end

  def self.d3p2
    [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
      .map { Slope.new(right: _1, down: _2).trees.size }
      .reduce(&:*)
  end

  attr_reader :right, :down, :grid, :locations

  def initialize(right:, down:)
    @right = right
    @down = down
    @grid = Grid.new

    @locations =
      (0...@grid.height)
      .step(@down)
      .map
      .with_index { @grid.location(right: @right * _2, down: _1) }
      .compact
  end

  def trees
    @locations.select(&:tree?)
  end
end
