require 'geometry'
require 'matrix'
require 'transform'
require 'material'

Given(/s ← sphere\(\)/) do
  @s = Sphere.new()
end

When('xs ← intersect\(s, r)') do
  @xs = @s.intersect(@r)
end

Then('xs.count = {int}') do |int|
  expect(@xs.count).to eq int
end

Then('xs[{int}] = {float} And xs[{int}] = {float}') do |int, float, int2, float2|
  expect(@xs[int]).to eq float
  expect(@xs[int2]).to eq float2
end

Then('s.transform = identity_matrix') do
  expect(@s.transform).to eq Matrix.identity
end

Given('t ← translation\({float}, {float}, {float})') do |x, y, z|
  @t = Transform.translation(x, y, z)
end

When('set_transform\(s, t)') do
  @s.set_transform(@t)
end

Then('s.transform = t') do
  expect(@s.transform).to eq @t
end

Then('xs[{int}].t = {float}') do |int, float|
  expect(@xs[int].t).to eq float
end

When(/set_transform\(s, translation\(([^,]+), ([^,]+), ([^,]+)\)\)/) do |sx, sy, sz|
  x = sx.to_f
  y = sy.to_f
  z = sz.to_f
  @s.set_transform(Transform.translation(x, y, z))
end

When(/set_transform\(s, scaling\(([^,]+), ([^,]+), ([^,]+)\)\)/) do |sx, sy, sz|
  x = sx.to_f
  y = sy.to_f
  z = sz.to_f
  @s.set_transform(Transform.scaling(x, y, z))
end

When(/n ← normal_at\(s, point\(([^√,]+), ([^√,]+), ([^√,]+)\)\)/) do |sx, sy, sz|
  x = sx.to_f
  y = sy.to_f
  z = sz.to_f
  @n = @s.normal_at(Point.new(x, y, z))
end

When(/n ← normal_at\(s, point\(√3\/3, √3\/3, √3\/3\)\)/) do
  f = Math.sqrt(3) / 3.0
  @n = @s.normal_at(Point.new(f, f, f))
end

Then('n = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@n).to eq Vector.new(x, y, z)
end

Then('n = normal_at\(s, point(√3/3, √3/3, √3/3))') do
  f = Math.sqrt(3) / 3.0
  expect(@n).to eq @s.normal_at(Point.new(f, f, f))
end

Then(/n = vector\(√3\/3, √3\/3, √3\/3\)/) do
  f = Math.sqrt(3) / 3.0
  expect(@n).to eq Vector.new(f, f, f)
end

Then('n = normalize\(n)') do
  expect(@n).to eq @n.normalize
end

Given('m ← scaling\({float}, {float}, {float}) * rotation_z\(π\/{float})') do |x, y, z, float|
  @m = Transform.scaling(x, y, z) * Transform.rotation_z(Math::PI / float)
end

Given('set_transform\(s, m)') do
  @s.set_transform(@m)
end

When(/n ← normal_at\(s, point\(([^√,]+), √2\/2, -√2\/2\)\)/) do |sx|
  x = sx.to_f
  y = Math.sqrt(2) / 2.0
  z = -Math.sqrt(2) / 2.0
  @n = @s.normal_at(Point.new(x, y, z))
end

When('m ← s.material') do
  @m = @s.material
end

Then(/m = material\(\)/) do
  @m = Material.new
end

Given('m.ambient ← {float}') do |float|
  @m.ambient = float
end

When('s.material ← m') do
  @s.material = @m
end

Then('s.material = m') do
  expect(@s.material).to eq @m
end
