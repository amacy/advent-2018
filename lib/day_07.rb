class Day07
  INPUT = File.readlines("config/day_07.txt").map(&:chomp)

  STEP_TO_TIME = {
    "A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5,
    "F" => 6, "G" => 7, "H" => 8, "I" => 9, "J" => 10,
    "K" => 11, "L" => 12, "M" => 13, "N" => 14, "O" => 15,
    "P" => 16, "Q" => 17, "R" => 18, "S" => 19, "T" => 20,
    "U" => 21, "V" => 22, "W" => 23, "X" => 24, "Y" => 25,
    "Z" => 26,
  }

  class Worker
    attr_reader :step

    def initialize
      @step = nil
      @time_on_step = 0
    end

    def free?
      @step.nil?
    end

    def start_work!(step)
      @step = step
    end

    def do_work!
      raise if @step.nil?
      @time_on_step += 1
    end

    def complete_work!
      @step = nil
      @time_on_step = 0
    end
  end

  def self.part_1(input=INPUT)
    _do_work(input, 0, 1).first
  end

  def self.part_2(input=INPUT, base_time=60, worker_count=5)
    _do_work(input, base_time, worker_count).last
  end

  def self._do_work(input, base_time, worker_count)
    completed_steps = []
    time_elapsed = 0

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
    workers = worker_count.times.map { |_| Worker.new }

    loop do
      workers.each do |worker|
        if worker.free?
          step = queue.shift
          next if step.nil?
          worker.start_work!(step)
        end

        if !worker.free?
          time_spent_on_current_task = worker.do_work!
          if time_spent_on_current_task == (STEP_TO_TIME[worker.step] + base_time)
            completed_steps << worker.step
            worker.complete_work!
          end
        end
      end

      time_elapsed += 1
      remaining_steps = all_steps - (completed_steps + queue + workers.map(&:step).compact)

      remaining_steps.each do |step|
        dependencies = all_dependencies[step]
        if ((dependencies & completed_steps) == dependencies)
          queue << step
        else
          next
        end
      end

      if remaining_steps.empty? && queue.empty? && workers.map(&:step).compact.empty?
        return [completed_steps.join, time_elapsed]
      else
        queue.sort!
      end
    end
  end
end
