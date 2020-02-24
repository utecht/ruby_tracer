require_relative './tuple'

class Canvas
  attr_reader :width, :height

  def initialize(w, h)
    @width = w
    @height = h
    @data = Array.new(w * h, Color.new(0.0, 0.0, 0.0))
  end

  def write_pixel(x, y, color)
    if x > @width or y > @height or x < 0 or y < 0
      puts "#{x}, #{y} out of bounds"
      return false
    end
    @data[(y * @width) + x] = color
  end

  def pixel_at(x, y)
    if x > @width or y > @height or x < 0 or y < 0
      puts "#{x}, #{y} out of bounds"
      return false
    end
    @data[(y * @width) + x]
  end

  def pixel_color(color)
    val = (color * 255).ceil
    return 0 if val < 0
    return 255 if val > 255
    return val
  end

  def canvas_to_ppm
    ppm = <<~HEADER.chomp
      P3
      #{@width} #{@height}
      255
    HEADER
    @height.times do |y|
      ppm += "\n"
      row = []
      @width.times do |x|
        c = pixel_at(x, y)
        r = pixel_color(c.red)
        g = pixel_color(c.green)
        b = pixel_color(c.blue)
        row.push("#{r} #{g} #{b}")
      end
      full_row = row.join(" ")
      while full_row.length > 70
        slice_spot = 70
        while full_row[slice_spot] != ' '
          slice_spot -= 1
        end
        ppm += full_row.slice!(0..slice_spot).strip
        ppm += "\n"
      end
      ppm += full_row
    end
    ppm += "\n"
    return ppm
  end
end
