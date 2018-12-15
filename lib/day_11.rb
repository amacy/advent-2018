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
    grid = {}
    squares = {}

    GRID_RANGE.each do |x|
      grid[x] ||= {}
      GRID_RANGE.each do |y|
        grid[x][y] ||= FuelCell.new(x, y).power_level(grid_serial_number)
      end
    end

    max_square = 0
    max_square_x_y = nil

    grid.each do |x, row|
      break if x == 299
      row.each do |y, power_level|
        next if y >= 299
        squares[x] ||= {}
        sum = power_level +
          grid[x+1][y] +
          grid[x+2][y] +
          grid[x][y+1] +
          grid[x][y+2] +
          grid[x+1][y+1] +
          grid[x+2][y+1] +
          grid[x+1][y+2] +
          grid[x+2][y+2]
        squares[x][y] = sum

        if sum > max_square
          max_square_x_y = "#{x},#{y}"
          max_square = sum
        end
      end
    end

    max_square_x_y
  end
end
