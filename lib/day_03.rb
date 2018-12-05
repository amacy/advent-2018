require "set"

module Day03
  INPUT = File.readlines("config/day_03.txt").map(&:chomp)
  Claim = Struct.new(:id, :x, :y, :width, :height)

  def self.overlapping_area(input=INPUT)
    claims = _parse_input(input)
    graph = _generate_graph(claims)

    graph.inject(0) do |sum, row|
      next sum if row.nil?
      row.each do |node|
        next sum if node.nil?
        sum += 1 if node.length > 1
      end
      sum
    end
  end

  def self.non_overlapping_claim(input=INPUT)
    claims = _parse_input(input)
    graph = _generate_graph(claims)

    solo_nodes = []
    graph.each_with_index do |row, x|
      next if row.nil?
      row.each_with_index do |node, y|
        next if node.nil?
        solo_nodes << node.first if node.length == 1
      end
    end

    claim_to_count = solo_nodes.flatten.inject({}) do |claim_to_count, claim|
      claim_to_count[claim] ||= 0
      claim_to_count[claim] += 1
      claim_to_count
    end

    claim_to_count.each do |claim, count|
      return claim.id if claim.width * claim.height == count
    end
  end

  def self._generate_graph(claims)
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

    graph
  end

  def self._parse_input(input)
    input.map do |line|
      raw_id, remainder = line.split(/ @ /)
      coordinates, dimensions = remainder.split(": ")

      id = raw_id.gsub("#", "").to_i
      x, y = coordinates.split(",").map(&:to_i)
      width, height = dimensions.split("x").map(&:to_i)

      Claim.new(id, x, y, width, height)
    end
  end
end
