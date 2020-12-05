#!/usr/bin/env ruby
# frozen_string_literal: true

regexp = /(?<min>\d+)-(?<max>\d+) (?<char>\w+): (?<password>\w+)/
lines = File.read('day2.txt').split("\n").map { _1.match(regexp).named_captures }

def part1(hsh)
  range = (hsh['min'].to_i..hsh['max'].to_i)
  occurrences = hsh['password'].scan(hsh['char']).size
  range.cover?(occurrences)
end

def part2(hsh)
  (hsh['password'][hsh['min'].to_i - 1] == hsh['char']) ^
    (hsh['password'][hsh['max'].to_i - 1] == hsh['char'])
end

%w[part1 part2].each do |str|
  puts lines.select(&method(str)).size
end
