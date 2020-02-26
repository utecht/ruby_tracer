require 'geometry'
require 'matrix'
require 'transform'

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
