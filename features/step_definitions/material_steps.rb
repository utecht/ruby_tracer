require 'material'
require 'tuple'

Given(/m ← material\(\)/) do
  @m = Material.new
end

Then('m.color = color\({float}, {float}, {float})') do |float, float2, float3|
  expect(@m.color).to eq Color.new(float, float2, float3)
end

Then('m.ambient = {float}') do |float|
  expect(@m.ambient).to eq float
end

Then('m.diffuse = {float}') do |float|
  expect(@m.diffuse).to eq float
end

Then('m.specular = {float}') do |float|
  expect(@m.specular).to eq float
end

Then('m.shininess = {float}') do |float|
  expect(@m.shininess).to eq float
end

Given('eyev ← vector\({float}, {float}, {float})') do |x, y, z|
  @eyev = Vector.new(x, y, z)
end

Given('normalv ← vector\({float}, {float}, {float})') do |x, y, z|
  @normalv = Vector.new(x, y, z)
end

Given(/light ← point_light\(point\(([^,]+), ([^,]+), ([^,]+)\), color\(([^,]+), ([^,]+), ([^,]+)\)\)/) do |xs, ys, zs, rs, gs, bs|
  x = xs.to_f
  y = ys.to_f
  z = zs.to_f
  r = rs.to_f
  g = gs.to_f
  b = bs.to_f
  @light = PointLight.new(Point.new(x, y, z), Color.new(r, g, b))
end

When('result ← lighting\(m, light, position, eyev, normalv)') do
  @result = @m.lighting(@light, @position, @eyev, @normalv)
end

Then('result = color\({float}, {float}, {float})') do |float, float2, float3|
  expect(@result).to eq Color.new(float, float2, float3)
end

Given('eyev ← vector\({float}, √2\/{float}, -√2\/{float})') do |x, y, z|
  y = Math.sqrt(2) / y
  z = -Math.sqrt(2) / z
  @eyev = Vector.new(x, y, z)
end

Given('eyev ← vector\({float}, -√2\/{float}, -√2\/{float})') do |x, y, z|
  y = -Math.sqrt(2) / y
  z = -Math.sqrt(2) / z
  @eyev = Vector.new(x, y, z)
end
