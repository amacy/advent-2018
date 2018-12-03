require "set"

module Day01
  INPUT = File.readlines("config/day_01.txt").map { |line| line.chomp.to_i }

  def self.resulting_frequency(input=INPUT)
    input.inject(&:+)
  end

  def self.first_frequency_reached_twice(input=INPUT)
    current_frequency = 0
    reached = Set.new
    reached << current_frequency

    loop do
      input.each do |i|
        new_frequency = current_frequency + i
        return new_frequency if reached.include?(new_frequency)
        reached << new_frequency
        current_frequency = new_frequency
      end
    end
  end
end
