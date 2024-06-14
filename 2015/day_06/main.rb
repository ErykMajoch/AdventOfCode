def parse_file
  File.read("input.txt").split("\n")
end

def parse_command command
  /(?<command>[a-zA-Z ]+)(?<start>[0-9]+,[0-9]+) through (?<end>[0-9]+,[0-9]+)/.match(command)
end

def part_one
  grid = Array.new(1000) { Array.new(1000) { false } }
  parse_file.each do |line|
    command = parse_command line
    start = command[:start].split(",").map{|n| n.to_i}
    stop = command[:end].split(",").map{|n| n.to_i}

      (start[1]..stop[1]).each do |y|
        (start[0]..stop[0]).each do |x|
          case command[:command].strip
          when "turn off"
            grid[y][x] = false
          when "turn on"
            grid[y][x] = true
          when "toggle"
            grid[y][x] = !grid[y][x]
          end
        end
      end
  end

  grid.flatten.map{|n| n ? 1 : 0}.inject(0, :+)

end

def part_two
  grid = Array.new(1000) { Array.new(1000) { 0 } }
  parse_file.each do |line|
    command = parse_command line
    
    start = command[:start].split(",").map{|n| n.to_i}
    stop = command[:end].split(",").map{|n| n.to_i}
   
   (start[1]..stop[1]).each do |y|
      (start[0]..stop[0]).each do |x|
        case command[:command].strip
        when "turn off"
          grid[y][x] = [0, grid[y][x] - 1].max
        when "turn on"
          grid[y][x] += 1
        when "toggle"
          grid[y][x] += 2
        end
      end
    end
  end

  grid.flatten.inject(0, :+)

end

puts "Part One: #{part_one}"
puts "Part Two: #{part_two}"
