require '../lib/tuple'
require '../lib/matrix'
require '../lib/transform'
require '../lib/geometry'
require '../lib/ray'
require '../lib/light'
require '../lib/png_canvas'


origin = Point.new(0, 0, -5)
wall_z = 10
wall_size = 7.0
canvas_pixels = 500
pixel_size = wall_size / canvas_pixels
half = wall_size / 2.0
canvas = PNG_Canvas.new(canvas_pixels, canvas_pixels)

sphere = Sphere.new
sphere.material.color = Color.new(1, 0.2, 1)

light_position = Point.new(-10, 10, -10)
light_color = Color.new(1, 1, 1)
light = PointLight.new(light_position, light_color)


canvas_pixels.times do |x|
  puts "#{(x.to_f / canvas_pixels.to_f) * 100}%"
  canvas_pixels.times do |y|
    tx = -half + pixel_size * x
    ty = half - pixel_size * y
    target = Point.new(tx, ty, wall_z)
    ray = Ray.new(origin, (target - origin).normalize)
    hit = sphere.intersect(ray).hit
    unless hit.nil?
      point = ray.position(hit.t)
      normal = hit.object.normal_at(point)
      eye = -ray.direction
      color = hit.object.material.lighting(light, point, eye, normal)
      canvas.write_pixel(x, y, color)
    end
  end
end

canvas.write_png("sphere2.png")
