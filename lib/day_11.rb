require "set"

class Day11
  GRID_RANGE = 1..300

  FuelCell = Struct.new(:x, :y) do
    def power_level(grid_serial_number)
      i = ((rack_id * y) + grid_serial_number) * rack_id

      i.to_s[-3].to_i - 5
    end

    def rack_id
      x + 10
    end
  end

  def self.part_1(grid_serial_number)
    grid = _grid(grid_serial_number)
    _max_square(grid, 3).keys.first
  end

  def self.part_2(grid_serial_number)
    grid = _grid(grid_serial_number)
    GRID_RANGE.each do |dimensions|
      _max_square(grid, dimensions)
    end
  end

  def self._grid(serial_number)
    grid = {}

    GRID_RANGE.each do |x|
      grid[x] ||= {}
      GRID_RANGE.each do |y|
        grid[x][y] ||= FuelCell.new(x, y).power_level(serial_number)
      end
    end

    grid
  end

  def self._max_square(grid, dimensions)
    max_sum = 0
    max_square = nil

    grid.each do |x, row|
      break if x == 299
      row.each do |y, _|
        next if y >= 299

        combinations = Set.new
        sum = 0
        (0..dimensions-1).each do |x_modifier|
          (0..dimensions-1).each do |y_modifier|
            key = [x+x_modifier, y+y_modifier]
            next if combinations.include?(key)
            sum += grid[x+x_modifier][y+y_modifier]
            combinations << key
          end
        end

        if sum > max_sum
          max_square = "#{x},#{y}"
          max_sum = sum
        end
      end
    end

    { max_square => max_sum }
  end
end
