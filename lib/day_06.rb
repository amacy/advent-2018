class Day06
  INPUT = File.readlines("config/day_06.txt").map do |line|
    line.chomp.split(", ").map(&:to_i)
  end

  Coord = Struct.new(:id, :x, :y)

  def self.part_1(input=INPUT)
    coords, graph = _generate_coords_and_graph(input)
    coord_id_to_count = {}

    graph.dup.each_with_index do |row, x|
      row.each_with_index do |coord, y|
        if coord.nil?
          closest_coord_ids = _closest_coords(graph, coords, x, y).map(&:id)
          graph[x][y] = closest_coord_ids
          if closest_coord_ids.length == 1
            coord_id_to_count[closest_coord_ids.first] ||= 1
            coord_id_to_count[closest_coord_ids.first] += 1
          end
        end
      end
    end

    coords.each do |coord|
      graph.each do |row|
        if row.first == [coord.id] || row.last == [coord.id]
          coord_id_to_count.delete(coord.id)
        end
      end

      if graph.first.include?([coord.id]) || graph.last.include?([coord.id])
        coord_id_to_count.delete(coord.id)
      end
    end

    coord_id_to_count.values.max
  end

  def self.part_2(input=INPUT, max_distance_to_all_coords=10_000)
    coords, graph = _generate_coords_and_graph(input)
    coords_within_range = 0

    graph.each_with_index do |row, x|
      row.each_with_index do |_, y|
        total_distance = coords.inject(0) do |sum, coord|
          sum += _distance_from_coord(coord, x, y)
        end

        if total_distance < max_distance_to_all_coords
          coords_within_range += 1
        end
      end
    end

    coords_within_range
  end

  def self._generate_coords_and_graph(input)
    coords = []
    graph = []
    max_y = 0

    input.each_with_index do |(y, x), id|
      max_y = y if y > max_y
      coord = Coord.new(id, x, y)
      graph[x] ||= []
      graph[x][y] = coord
      coords << coord
    end

    graph = graph.dup.map do |row|
      if row.nil?
        r = []
        r[max_y] = nil
        r
      else
        r = row.dup
        r[max_y] ||= nil
        r
      end
    end

    [coords, graph]
  end

  def self._closest_coords(graph, coords, x, y)
    closest_coords = []
    distance_from_closest_coord = graph.length

    coords.each do |coord|
      distance = _distance_from_coord(coord, x, y)
      if distance == distance_from_closest_coord
        closest_coords << coord
      elsif distance < distance_from_closest_coord
        closest_coords = [coord]
        distance_from_closest_coord = distance
      end
    end

    closest_coords
  end

  def self._distance_from_coord(coord, x, y)
    (x - coord.x).abs + (y - coord.y).abs
  end
end
