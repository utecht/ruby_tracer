require 'ray'
require 'tuple'

Given('origin ← point\({float}, {float}, {float})') do |x, y, z|
  @origin = Point.new(x, y, z)
end

Given('direction ← vector\({float}, {float}, {float})') do |x, y, z|
  @direction = Vector.new(x, y, z)
end

When('r ← ray\(origin, direction)') do
  @r = Ray.new(@origin, @direction)
end

Then('r.origin = origin') do
  expect(@r.origin).to eq @origin
end

Then('r.direction = direction') do
  expect(@r.direction).to eq @direction
end

Given(/r ← ray\(point\(([^,]+), ([^,]+), ([^,]+)\), vector\(([^,]+), ([^,]+), ([^,]+)\)\)/) do |s1, s2, s3, s4, s5, s6|
  x = s1.to_f
  y = s2.to_f
  z = s3.to_f
  x2 = s4.to_f
  y2 = s5.to_f
  z2 = s6.to_f
  @r = Ray.new(Point.new(x, y, z), Vector.new(x2, y2, z2))
end

Then('position\(r, {float}) = point\({float}, {float}, {float})') do |t, x, y, z|
  expect(@r.position(t)).to eq Point.new(x, y, z)
end
