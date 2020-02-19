require_relative './canvas'
require 'chunky_png'

class PNG_Canvas < Canvas
  def initialize(w, h)
    super(w, h)
  end

  def write_png(filename)
    png = ChunkyPNG::Image.new(@width, @height, ChunkyPNG::Color::TRANSPARENT)
    @width.times do |w|
      @height.times do |h|
        c = pixel_at(w, h)
        png[w,h] = ChunkyPNG::Color.rgba(pixel_color(c.red), pixel_color(c.green), pixel_color(c.blue), 255)
      end
    end
    png.save(filename, :interlace => true)
  end

end
