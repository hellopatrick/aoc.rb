# frozen_string_literal: true

require 'set'

def parse(input)
  height = input.size
  width = input[0].strip.length

  antennas = Hash.new { |hash, key| hash[key] = [] }

  input.each_with_index do |line, y|
    line.strip.chars.each_with_index do |c, x|
      antennas[c].unshift([x, y]) if c != '.'
    end
  end

  { height: height, width: width, antennas: antennas }
end

puzzle = parse(ARGF.readlines)

antennas = puzzle[:antennas]

anti = Set.new
antennas.each_value do |v|
  v.combination(2).each do |p, q|
    px, py = p
    qx, qy = q

    dx = px - qx
    dy = py - qy

    while px >= 0 && px < puzzle[:width] && py >= 0 && py < puzzle[:height]
      anti.add([px, py])

      px += dx
      py += dy
    end

    while qx >= 0 && qx < puzzle[:width] && qy >= 0 && qy < puzzle[:height]
      anti.add([qx, qy])

      qx -= dx
      qy -= dy
    end
  end
end

puts anti.size
