# typed: strict
# frozen_string_literal: true

# https://adventofcode.com/2020/day/2
class Day2
  extend T::Sig

  REGEXP = T.let(
    /(?<min>\d+)-(?<max>\d+) (?<char>\w+): (?<password>\w+)/.freeze,
    Regexp
  )

  sig { void }
  def initialize
    @arr =
      T.let(
        File
        .read('day2.txt')
        .split("\n")
        .map { T.must(_1.match(REGEXP)).named_captures },
        T::Array[T::Hash[T.untyped, T.untyped]]
      )
  end

  sig { returns(T::Array[Integer]) }
  def call
    part1 = @arr.select do |hsh|
      range = (hsh['min'].to_i..hsh['max'].to_i)
      occurrences = hsh['password'].scan(hsh['char']).size
      range.cover?(occurrences)
    end.size

    part2 = @arr.select do |hsh|
      (hsh['password'][hsh['min'].to_i - 1] == hsh['char']) ^
        (hsh['password'][hsh['max'].to_i - 1] == hsh['char'])
    end.size

    [part1, part2]
  end
end
