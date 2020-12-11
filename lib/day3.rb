# typed: strict
# frozen_string_literal: true

class Day3
  extend T::Sig

  sig { returns(Integer) }
  def self.part1
    new(right: 3, down: 1).trees.size
  end

  sig { returns(Integer) }
  def self.part2
    [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
      .map { new(right: _1, down: _2).trees.size }
      .reduce(&:*)
  end

  sig { params(right: Integer, down: Integer).void }
  def initialize(right:, down:)
    @right = right
    @down = down

    @grid = T.let(
      File.read('day3.txt').split("\n").map(&:chars),
      T::Array[T::Array[String]]
    )
  end

  sig { returns(T::Array[String]) }
  def downs
    (0...height).step(@down).to_a
  end

  sig { returns(Integer) }
  def height
    @grid.size
  end

  sig { returns(T::Array[String]) }
  def slope
    downs.map.with_index do |down, index|
      next if down > height

      T.must(@grid[down])[index * @right % width]
    end.compact
  end

  sig { returns(T::Array[String]) }
  def trees
    slope.select { _1.match?(/\A#\z/) }
  end

  sig { returns(Integer) }
  def width
    T.must(@grid.first).size
  end
end
