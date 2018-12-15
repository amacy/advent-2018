class Day14
  ELF_1_STARTING_SCORE = 3
  ELF_2_STARTING_SCORE = 7
  TRAILING_DIGITS = 10

  def self.part_1(practice_count)
    _solve do |scores|
      if scores.length >= practice_count + TRAILING_DIGITS
        return scores[practice_count...practice_count + TRAILING_DIGITS].join
      end
    end
  end

  def self.part_2(score_sequence)
    iterations = 0
    score_sequence_length = score_sequence.length
    _solve do |scores|
      starting_index = scores.length - 2 - score_sequence_length
      end_of_string = scores[starting_index..-1]
      if end_of_string && end_of_string.join.match?(score_sequence)
        match = scores.join.match(/^(.*?)#{score_sequence}/)
        return match.captures.first.length if match
      end
    end
  end

  def self._solve(&block)
    elf_1_location = 0
    elf_2_location = 1
    scores = [ELF_1_STARTING_SCORE, ELF_2_STARTING_SCORE]

    loop do
      yield(scores)
      new_scores = (scores[elf_1_location] + scores[elf_2_location]).to_s.split(//).map(&:to_i)

      new_scores.each { |i| scores << i }
      elf_1_location = _new_elf_location(scores, elf_1_location)
      elf_2_location = _new_elf_location(scores, elf_2_location)
    end
  end

  def self._new_elf_location(scores, current_location)
    moves = scores[current_location] + 1
    new_current_location = nil
    loop do
      return new_current_location if new_current_location && scores[new_current_location]
      scores_length = scores.length
      if moves >= scores_length
        moves = moves % scores_length
      else
        if scores[current_location + moves]
          new_current_location = current_location + moves
        else
          new_current_location = current_location + moves - scores_length
        end
      end
    end
  end
end
