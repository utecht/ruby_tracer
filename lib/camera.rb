require_relative './matrix'
require_relative './ray'
require_relative './tuple'

class Camera
  attr_reader :hsize, :vsize, :field_of_view, :pixel_size
  attr_accessor :transform

  def initialize(hsize, vsize, field_of_view)
    @hsize = hsize
    @vsize = vsize
    @field_of_view = field_of_view
    @transform = Matrix.identity
    calculate_pixel_size
  end

  def calculate_pixel_size
    half_view = Math.tan(@field_of_view / 2)
    aspect = @hsize.to_f / @vsize.to_f
    if aspect >= 1
      @half_width = half_view
      @half_height = half_view / aspect
    else
      @half_width = half_view * aspect
      @half_height = half_view
    end
    @pixel_size = (@half_width * 2) / @hsize
  end

  def ray_for_pixel(x, y)
    xoffset = (x + 0.5) * @pixel_size
    yoffset = (y + 0.5) * @pixel_size

    world_x = @half_width - xoffset
    world_y = @half_height - yoffset

    pixel = @transform.inverse * Point.new(world_x, world_y, -1)
    origin = @transform.inverse * Point.new(0, 0, 0)
    direction = (pixel - origin).normalize

    Ray.new(origin, direction)
  end

  def render(world, canvas)
    @vsize.times do |y|
      @hsize.times do |x|
        ray = ray_for_pixel(x, y)
        color = world.color_at(ray)
        canvas.write_pixel(x, y, color)
      end
    end
    return canvas
  end

end
