require "date"

class Day04
  INPUT = File.readlines("config/day_04.txt").map(&:chomp)

  class Entry
    attr_reader :time, :text, :time_for_sorting

    def initialize(line)
      @raw_timestamp, @text = line.gsub("[", "").split("] ")
      @time = _parse_time
    end

    def julian_date
      # Time#to_date returns the wrong date for some times
      normalized_time = _normalized_time
      date = Date.new(normalized_time.year, normalized_time.month, normalized_time.day)
      date.jd
    end

    def _normalized_time
      if @time.hour == 23
        hour = 0
        minute = 0
        if @time.day == 31
          day = 1
          month = @time.month + 1
        else
          day = @time.day + 1
        end
      end

      Time.new(
        @time.year,
        month || @time.month,
        day || @time.day,
        hour || @time.hour,
        minute || @time.min,
      )
    end

    def _parse_time
      day_remainder, hour_remainder = @raw_timestamp.split(" ")

      year, month, day = day_remainder.split("-").map(&:to_i)
      hour, minute = hour_remainder.split(":").map(&:to_i)

      Time.new(year, month, day, hour, minute)
    end
  end

  def self.strategy_1(input=INPUT)
    new(input).strategy_1
  end

  def self.strategy_2(input=INPUT)
    new(input).strategy_2
  end

  def initialize(input)
    @guard_to_min_slept = {}
    @minute_to_sleeping_guard = {}
    @graph = _generate_graph(input)
  end

  def strategy_1
    sleepiest_guard = @guard_to_min_slept.key(@guard_to_min_slept.values.max)
    sleep_by_minute = {}
    @graph.each_with_index do |(_, row), _|
      next if row.nil?
      row.each_with_index do |guard, minute|
        if guard == sleepiest_guard
          sleep_by_minute[minute] ||= 0
          sleep_by_minute[minute] += 1
        end
      end
    end

    most_frequent_minute = sleep_by_minute.key(sleep_by_minute.values.max)
    sleepiest_guard * most_frequent_minute
  end

  def strategy_2
    minute, current_guard = @minute_to_sleeping_guard.key(@minute_to_sleeping_guard.values.max)
    minute * current_guard
  end

  def _generate_graph(input)
    entries = input.map { |line| Entry.new(line) }.sort { |a, b| a.time <=> b.time }
    graph = {}
    sleeping_start_time = nil
    current_guard = nil

    entries.each do |entry|
      if entry.text.include?("Guard")
        graph[entry.julian_date] ||= []

        current_guard = entry.text.scan(/\d+/).first.to_i

        @guard_to_min_slept[current_guard] ||= 0
      elsif entry.text.include?("falls asleep")
        minute = entry.time.min

        graph[entry.julian_date][minute] = current_guard

        @guard_to_min_slept[current_guard] += 1

        @minute_to_sleeping_guard[[minute, current_guard]] ||= 0
        @minute_to_sleeping_guard[[minute, current_guard]] += 1

        sleeping_start_time = entry.time
      elsif entry.text.include?("wakes up")
        (sleeping_start_time.min...entry.time.min).each do |minute|
          graph[entry.julian_date][minute] = current_guard

          @guard_to_min_slept[current_guard] += 1

          @minute_to_sleeping_guard[[minute, current_guard]] ||= 0
          @minute_to_sleeping_guard[[minute, current_guard]] += 1
        end
        sleeping_start_time = nil
      end
    end

    graph
  end
end
