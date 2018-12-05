require "set"

module Day03
  INPUT = File.readlines("config/day_03.txt").map(&:chomp)
  Claim = Struct.new(:x, :y, :width, :height)

  def self.overlapping_area(input=INPUT)
    claims = _parse_input(input)
    graph = []

    claims.each do |claim|
      (claim.x..claim.x + claim.width - 1).each do |x|
        (claim.y..claim.y + claim.height - 1).each do |y|
          graph[x] ||= []
          graph[x][y] ||= Set.new
          graph[x][y] << claim
        end
      end
    end

    graph.inject(0) do |sum, row|
      next sum if row.nil?
      row.each do |node|
        next sum if node.nil?
        sum += 1 if node.length > 1
      end
      sum
    end
  end

  def self._parse_input(input)
    input.map do |line|
      coordinates, dimensions = line.split(/@ /).last.split(": ")

      x, y = coordinates.split(",").map(&:to_i)
      width, height = dimensions.split("x").map(&:to_i)

      Claim.new(x, y, width, height)
    end
  end
end
