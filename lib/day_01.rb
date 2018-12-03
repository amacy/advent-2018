module Day01
  INPUT = File.readlines("config/day_01.txt").map { |line| line.chomp.to_i }

  def self.process(input=INPUT)
    input.inject(&:+)
  end
end
