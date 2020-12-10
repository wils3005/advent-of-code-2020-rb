# typed: strict
# frozen_string_literal: true

# https://adventofcode.com/2020/day/1
class Day1
  extend T::Sig

  sig { void }
  def initialize
    @arr = T.let(
      File.read('day1.txt').split("\n").map(&:to_i),
      T::Array[Integer]
    )
  end

  sig { returns(T::Array[T.nilable(Integer)]) }
  def call
    (2..3).map do |int|
      T
        .must(@arr.combination(int).find { _1.sum == 2020 })
        .reduce(1) { _1 * _2 }
    end
  end
end
