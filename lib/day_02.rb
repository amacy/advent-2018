require "set"

module Day02
  INPUT = File.readlines("config/day_02.txt").map(&:chomp)

  def self.checksum(input=INPUT)
    twice_count = 0
    thrice_count = 0

    input.each do |line|
      counts_by_letter = line.split(//).inject({}) do |hash, character|
        hash[character] ||= 0
        hash[character] += 1
        hash
      end

      results = counts_by_letter.values.uniq
      twice_count += 1 if results.include?(2)
      thrice_count += 1 if results.include?(3)
    end

    twice_count * thrice_count
  end
end
