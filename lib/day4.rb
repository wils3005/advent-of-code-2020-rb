# typed: false
# frozen_string_literal: true

class Passport
  attr_reader :byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid

  def initialize(byr:, iyr:, eyr:, hgt:, hcl:, ecl:, pid:, cid: nil)
    @byr = byr
    @iyr = iyr
    @eyr = eyr
    @hcl = hcl
    @ecl = ecl
    @pid = pid
    @cid = cid

    @height_value, @height_units =
      hgt
      .match(/(?<value>\d+)(?<units>\w+)/)
      .named_captures
      .fetch_values('value', 'units')

    raise unless (1920..2002).cover?(@byr.to_i)
    raise unless (2010..2020).cover?(@iyr.to_i)
    raise unless (2020..2030).cover?(@eyr.to_i)
    raise unless height_valid?
    raise unless @hcl[/^#[0-9a-f]{6}$/]
    raise unless %w[amb blu brn gry grn hzl oth].include?(@ecl)
    raise unless @pid[/^\d{9}$/]
  end

  def height_valid?
    (@height_units == 'cm' && (150..193).cover?(@height_value.to_i)) ||
      (@height_units == 'in' && (59..76).cover?(@height_value.to_i))
  end
end

class Day4
  attr_reader :all, :errors, :passports

  def initialize
    @all =
      File
      .read('day4.txt')
      .split("\n\n")
      .map { |str| Hash[str.split(/\s/).map { _1.split(':') }] }
      .map { _1.transform_keys!(&:to_sym) }

    @errors = []

    @passports = @all.map do |hsh|
      Passport.new(**hsh)
    rescue StandardError => e
      @errors << e
    end

    @num_valid = @all.size - @errors.size
  end
end
