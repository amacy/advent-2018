class Day09
  def self.part_1(player_count, highest_marble)
    scores = (1..player_count).inject({}) do |hash, player|
      hash[player] = 0
      hash
    end

    current_player = 1
    current_marble = 0
    current_marble_index = 0

    board = [current_marble]

    (1..highest_marble).each do |next_marble|
      if next_marble % 23 == 0
        if current_marble_index >= 7
          current_marble_index -= 7
        else
          negative_index = current_marble_index - 7
          current_marble_index = board.length + negative_index
        end
        scores[current_player] += next_marble
        scores[current_player] += board.delete_at(current_marble_index)
        current_marble = board[current_marble_index]
      else
        next_marble_index = _next_marble_index(board, current_marble_index)

        if board[next_marble_index]
          board = board[0...next_marble_index] + [next_marble] + board[next_marble_index..board.length - 1]
        else
          board[next_marble_index] = next_marble
        end

        current_marble = next_marble
        current_marble_index = board.index(current_marble)
      end

      current_player += 1
      current_player = 1 if current_player > player_count
    end

    scores.values.max
  end

  def self._next_marble_index(board, current_marble_index)
    if board.length < 3
      1
    else
      if board[current_marble_index + 1]
        current_marble_index + 2
      else
        1
      end
    end
  end
end
