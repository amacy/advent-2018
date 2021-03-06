class Day05
  INPUT = File.readlines("config/day_05.txt").map(&:chomp).first.split(//)

  LOWERCASE_TO_UPPERCASE = {
    "a" => "A", "b" => "B", "c" => "C", "d" => "D", "e" => "E",
    "f" => "F", "g" => "G", "h" => "H", "i" => "I", "j" => "J",
    "k" => "K", "l" => "L", "m" => "M", "n" => "N", "o" => "O",
    "p" => "P", "q" => "Q", "r" => "R", "s" => "S", "t" => "T",
    "u" => "U", "v" => "V", "w" => "W", "x" => "X", "y" => "Y",
    "z" => "Z",
  }
  UPPERCASE_TO_LOWERCASE = LOWERCASE_TO_UPPERCASE.inject({}) do |hash, (lowercase, uppercase)|
    hash[uppercase] = lowercase
    hash
  end
  MAPPING = LOWERCASE_TO_UPPERCASE.merge(UPPERCASE_TO_LOWERCASE)

  def self.part_1(input=INPUT)
    output = _collapse_polymer(input)
    output.length
  end

  def self.part_2(input=INPUT)
    shortest_output = input

    LOWERCASE_TO_UPPERCASE.each do |(lowercase, uppercase)|
      reduced_input = input.dup
      # this is really slow
      reduced_input.delete(lowercase)
      reduced_input.delete(uppercase)
      output = _collapse_polymer(reduced_input)
      if output.length < shortest_output.length
        shortest_output = output
      end
    end

    shortest_output.length
  end

  def self._collapse_polymer(input)
    remainder = input.dup
    candidate = input.dup

    loop do
      candidate.each_with_index do |char, index|
        next if remainder[index].nil?
        prev_char_index = index - 1
        next_char_index = index + 1

        if prev_char_index >= 0
          if remainder[prev_char_index] == MAPPING[char]
            remainder[index] = nil
            remainder[prev_char_index] = nil
          end
        elsif next_char_index <= remainder.length - 1
          if remainder[next_char_index] == MAPPING[char]
            remainder[index] = nil
            remainder[next_char_index] = nil
          end
        end
      end

      if candidate == remainder.compact
        return candidate
      else
        remainder = remainder.compact
        candidate = remainder
      end
    end
  end
end
