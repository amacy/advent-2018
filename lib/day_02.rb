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

  def self.common_letters(input=INPUT)
    input.each do |id|
      id_letters = id.split(//)

      input.each do |candidate|
        next if id == candidate

        uncommon_letters = 0
        uncommon_letter_indices = []
        candidate_letters = candidate.split(//)

        (0..candidate_letters.length - 1).each do |index|
          if id_letters[index] == candidate_letters[index]
            next
          else
            uncommon_letter_indices << index
            uncommon_letters += 1
          end
        end

        if uncommon_letters == 1
          result = id_letters.dup
          result.delete_at(uncommon_letter_indices.first)
          return result.join
        end
      end
    end
  end
end
