require 'tuple'


Given('a ← tuple\({float}, {float}, {float}, {int})') do |x, y, z, w|
  @a = Tuple.new(x, y, z, w)
end

Given('a1 ← tuple\({float}, {float}, {float}, {int})') do |x, y, z, w|
  @a1 = Tuple.new(x, y, z, w)
end

Given('a2 ← tuple\({float}, {float}, {float}, {int})') do |x, y, z, w|
  @a2 = Tuple.new(x, y, z, w)
end

Given('p ← point\({float}, {float}, {float})') do |float, float2, float3|
  @p = Point.new(float, float2, float3)
end

Given('v ← vector\({float}, {float}, {float})') do |float, float2, float3|
  @v = Vector.new(float, float2, float3)
end

Given('c1 ← color\({float}, {float}, {float})') do |r, g, b|
  @c1 = Color.new(r, g, b)
end

Given('c2 ← color\({float}, {float}, {float})') do |r, g, b|
  @c2 = Color.new(r, g, b)
end
Given('p1 ← point\({float}, {float}, {float})') do |x, y, z|
  @p1 = Point.new(x, y, z)
end

Given('p2 ← point\({float}, {float}, {float})') do |x, y, z|
  @p2 = Point.new(x, y, z)
end

Given('c ← color\({float}, {float}, {float})') do |r, g, b|
  @c = Color.new(r, g, b)
end

Given('v1 ← vector\({float}, {float}, {float})') do |x, y, z|
  @v1 = Vector.new(x, y, z)
end

Given('v2 ← vector\({float}, {float}, {float})') do |x, y, z|
  @v2 = Vector.new(x, y, z)
end

Given('zero ← vector\({float}, {float}, {float})') do |x, y, z|
  @zero = Vector.new(x, y, z)
end

Then('p1 - p2 = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@p1 - @p2).to eq Vector.new(x, y, z)
end

Then('p - v = point\({float}, {float}, {float})') do |x, y, z|
  expect(@p - @v).to eq Point.new(x, y, z)
end

Then('v1 - v2 = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@v1 - @v2).to eq Vector.new(x, y, z)
end

Then('zero - v = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@zero - @v).to eq Vector.new(x, y, z)
end

Then('-a = tuple\({float}, {float}, {float}, {float})') do |x, y, z, w|
  expect(-@a).to eq Tuple.new(x, y, z, w)
end

Then('a * {float} = tuple\({float}, {float}, {float}, {float})') do |val, x, y, z, w|
  expect(@a * val).to eq Tuple.new(x, y, z, w)
end

Then('a divided {float} = tuple\({float}, {float}, {float}, {float})') do |float, x, y, z, w|
  expect(@a / float).to eq Tuple.new(x, y, z, w)
end

Then('magnitude\(v) = {float}') do |float|
  expect(@v.magnitude).to eq float
end

Then('magnitude\(v) = √14') do
  expect(@v.magnitude).to eq Math.sqrt(14)
end

Then('normalize\(v) = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@v.normalize).to eq Vector.new(x, y, z)
end

Then('normalize\(v) = approximately vector\({float}, {float}, {float})') do |x, y, z|
  expect(@v.normalize).to eq Vector.new(x, y, z)
end

When('norm ← normalize\(v)') do
  @norm = @v.normalize
end

Then('magnitude\(norm) = {float}') do |float|
  expect(@norm.magnitude).to eq float
end

Given('a ← vector\({float}, {float}, {float})') do |x, y, z|
  @a = Vector.new(x, y, z)
end

Given('b ← vector\({float}, {float}, {float})') do |x, y, z|
  @b = Vector.new(x, y, z)
end

Then('dot\(a, b) = {float}') do |float|
  expect(@a.dot(@b)).to eq float
end

Then('cross\(a, b) = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@a.cross(@b)).to eq Vector.new(x, y, z)
end

Then('cross\(b, a) = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@b.cross(@a)).to eq Vector.new(x, y, z)
end

Then('c.red = {float}') do |float|
  expect(@c.red).to eq float
end

Then('c.green = {float}') do |float|
  expect(@c.green).to eq float
end

Then('c.blue = {float}') do |float|
  expect(@c.blue).to eq float
end

Then('c1 + c2 = color\({float}, {float}, {float})') do |r, g, b|
  expect(@c1 + @c2).to eq Color.new(r, g, b)
end

Then('c1 - c2 = color\({float}, {float}, {float})') do |r, g, b|
  expect(@c1 - @c2).to eq Color.new(r, g, b)
end

Then('c1 * c2 = color\({float}, {float}, {float})') do |r, g, b|
  expect(@c1 * @c2).to eq Color.new(r, g, b)
end

Then('c * {float} = color\({float}, {float}, {float})') do |float, r, g, b|
  expect(@c * float).to eq Color.new(r, g, b)
end

Then('p = tuple\({float}, {float}, {float}, {int})') do |float, float2, float3, int|
  expect(@p).to eq Tuple.new(float, float2, float3, int)
end

Then('v = tuple\({float}, {float}, {float}, {int})') do |float, float2, float3, int|
  expect(@v).to eq Tuple.new(float, float2, float3, int)
end

Then('a.x = {float}') do |float|
  expect(@a.x).to eq float
end

Then('a.y = {float}') do |float|
  expect(@a.y).to eq float
end

Then('a.z = {float}') do |float|
  expect(@a.z).to eq float
end

Then('a.w = {float}') do |float|
  expect(@a.w).to eq float
end

Then('a is a point') do
  expect(@a.point?).to be true
end

Then('a is not a vector') do
  expect(@a.vector?).to be false
end

Then('a is not a point') do
  expect(@a.point?).to be false
end

Then('a is a vector') do
  expect(@a.vector?).to be true
end

Then('a1 + a2 = tuple\({float}, {float}, {float}, {int})') do |x, y, z, w|
  expect(@a1 + @a2).to eq Tuple.new(x, y, z, w)
end

Given('n ← vector\({float}, {float}, {float})') do |x, y, z|
  @n = Vector.new(x, y, z)
end

When('r ← reflect\(v, n)') do
  @r = @v.reflect(@n)
end

Then('r = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@r).to eq Vector.new(x, y, z)
end

Given('n ← vector\(√2\/{float}, √2\/{float}, {float})') do |xi, yi, z|
  x = Math.sqrt(2) / xi
  y = Math.sqrt(2) / yi
  @n = Vector.new(x, y, z)
end
