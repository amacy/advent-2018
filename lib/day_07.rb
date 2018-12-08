class Day07
  INPUT = File.readlines("config/day_07.txt").map(&:chomp)

  def self.part_1(input=INPUT)
    completed_steps = []

    all_dependencies = input.inject({}) do |hash, line|
      step = line[5]
      dependency = line[36]
      hash[dependency] ||= []
      hash[dependency] << step
      hash[dependency].sort
      hash
    end

    all_steps = (all_dependencies.keys + all_dependencies.values.flatten).uniq.sort
    remaining_steps = all_steps

    steps_without_dependencies = (all_steps - all_dependencies.keys).uniq.sort
    queue = steps_without_dependencies

    loop do
      current_step = queue.shift
      completed_steps << current_step
      remaining_steps = (all_steps - completed_steps) - queue

      remaining_steps.each do |step|
        dependencies = all_dependencies[step]
        if (dependencies & completed_steps) == dependencies
          queue << step
        else
          next
        end
      end

      if queue.empty?
        return completed_steps.join
      else
        queue.sort!
      end
    end
  end
end
