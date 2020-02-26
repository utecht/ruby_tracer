require '../lib/tuple'
require '../lib/matrix'
require '../lib/transform'
require '../lib/geometry'
require '../lib/ray'
require '../lib/png_canvas'

canvas = PNG_Canvas.new(50, 50)
red = Color.new(1.0, 0.0, 0.0)

point = Point.new(0, 20, 0)

canvas.write_png("sphere.png")
