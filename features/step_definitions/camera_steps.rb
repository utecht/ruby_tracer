require 'camera'
require 'matrix'
require 'tuple'
require 'transform'

Given('hsize ← {int}') do |int|
  @hsize = int
end

Given('vsize ← {int}') do |int|
  @vsize = int
end

Given('field_of_view ← π\/{int}') do |int|
  @field_of_view = Math::PI / int
end

When('c ← camera\(hsize, vsize, field_of_view)') do
  @c = Camera.new(@hsize, @vsize, @field_of_view)
end

Then('c.hsize = {int}') do |int|
  expect(@c.hsize).to eq int
end

Then('c.vsize = {int}') do |int|
  expect(@c.vsize).to eq int
end

Then('c.field_of_view = π\/{int}') do |int|
  expect(@c.field_of_view).to eq Math::PI / int
end

Then('c.transform = identity_matrix') do
  expect(@c.transform).to eq Matrix.identity
end

Given('c ← camera\({int}, {int}, π\/{int})') do |int, int2, int3|
  @c = Camera.new(int, int2, Math::PI / int3)
end

Then('c.pixel_size = {float}') do |float|
  expect(@c.pixel_size).to be_within(0.01).of(float)
end


When('r ← ray_for_pixel\(c, {int}, {int})') do |x, y|
  @r = @c.ray_for_pixel(x, y)
end

Then('r.origin = point\({float}, {float}, {float})') do |x, y, z|
  expect(@r.origin).to eq Point.new(x, y, z)
end

Then('r.direction = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@r.direction).to eq Vector.new(x, y, z)
end

When('c.transform ← rotation_y\(π\/{int}) * translation\({float}, {float}, {float})') do |int, x, y, z|
  @c.transform = Transform.rotation_y(Math::PI / int.to_f) * Transform.translation(x, y, z)
end

Then('r.direction = vector\(√2\/{int}, {int}, -√2\/{int})') do |int, int2, int3|
  x = Math.sqrt(2) / int.to_f
  y = int2.to_f
  z = -Math.sqrt(2) / int3.to_f
  expect(@r.direction).to eq Vector.new(x, y, z)
end

Given('c.transform ← view_transform\(from, to, up)') do
  @c.transform = Transform.view_transform(@from, @to, @up)
end

When('image ← render\(c, w)') do
  canvas = Canvas.new(@c.hsize, @c.vsize)
  @image = @c.render(@w, canvas)
end

Then('pixel_at\(image, {int}, {int}) = color\({float}, {float}, {float})') do |x, y, r, g, b|
  expect(@image.pixel_at(x, y)).to eq Color.new(r, g, b)
end
