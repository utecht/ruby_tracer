require '../lib/tuple'
require '../lib/matrix'
require '../lib/transform'
require '../lib/geometry'
require '../lib/ray'
require '../lib/png_canvas'

WIDTH = 500
HEIGHT = 500

canvas = PNG_Canvas.new(WIDTH, HEIGHT)
red = Color.new(1.0, 0.0, 0.0)

origin = Point.new(0, 0, 0)

sphere = Sphere.new
translate = Transform.translation(0, 0, WIDTH / 2)
scale = Transform.scaling(25, 25, 1)
sphere.set_transform(translate)
sphere.set_transform(scale)

WIDTH.times do |x|
  if WIDTH > 50
    puts "#{(x.to_f / WIDTH.to_f) * 100}%"
  end
  HEIGHT.times do |y|
    tx = x - (WIDTH / 2)
    ty = y - (HEIGHT / 2)
    z = WIDTH
    target = Point.new(tx, ty, z)
    ray = Ray.new(origin, (target - origin).normalize)
    unless sphere.intersect(ray).hit.nil?
      canvas.write_pixel(x, y, red)
    end
  end
end

canvas.write_png("sphere.png")
