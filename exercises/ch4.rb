require '../lib/tuple'
require '../lib/matrix'
require '../lib/transform'
require '../lib/png_canvas'

canvas = PNG_Canvas.new(50, 50)
red = Color.new(1.0, 0.0, 0.0)
blue = Color.new(0.0, 0.0, 1.0)
green = Color.new(0.0, 1.0, 0.0)

point = Point.new(0, 20, 0)

12.times do |oclock|
  p = Transform.translation(25, 25, 0) *
      Transform.rotation_z(oclock * (Math::PI / 6)) *
      point
  canvas.write_pixel(p.x.floor, p.y.floor, red)
end

canvas.write_png("clock.png")
