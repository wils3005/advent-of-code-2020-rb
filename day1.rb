#!/usr/bin/env ruby
# frozen_string_literal: true

arr =
  File
  .read('day1.txt')
  .split("\n")
  .map(&:to_i)

(2..3).each do |int|
  puts arr
    .combination(int)
    .find { _1.sum == 2020 }
    .reduce(&:*)
end
