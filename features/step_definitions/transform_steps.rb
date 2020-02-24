require 'transformation'
require 'tuple'

Given('transform ← translation\({float}, {float}, {float})') do |x, y, z|
  @transform = Transform.translation(x, y, z)
end

Then('transform * p = point\({float}, {float}, {float})') do |x, y, z|
  expect(@transform * @p).to eq Point.new(x, y, z)
end

Given('inv ← inverse\(transform)') do
  @inv = @transform.inverse
end

Then('inv * p = point\({float}, {float}, {float})') do |x, y, z|
  expect(@inv * @p).to eq Point.new(x, y, z)
end

Then('transform * v = v') do
  expect(@transform * @v).to eq @v
end

Given('transform ← scaling\({float}, {float}, {float})') do |x, y, z|
  @transform = Transform.scaling(x, y, z)
end

Then('transform * v = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@transform * @v).to eq Vector.new(x, y, z)
end

Then('inv * v = vector\({float}, {float}, {float})') do |x, y, z|
  expect(@inv * @v).to eq Vector.new(x, y, z)
end

Given('half_quarter ← rotation_x\(π \/ {float})') do |float|
  @half_quarter = Transform.rotation_x(Math.PI / float)
end

Given('full_quarter ← rotation_x\(π \/ {float})') do |float|
  @full_quarter = Transform.rotation_x(Math.PI / float)
end

Then('half_quarter * p = point\({int}, √2\/{int}, √2\/{int})') do |int, int2, int3|
  x = int
  y = Math.sqrt(2 / int2)
  z = Math.sqrt(2 / int3)
  expect(@half_quarter * @p).to eq Point.new(x, y, z)
end

Then('full_quarter * p = point\({float}, {float}, {float})') do |x, y, z|
  expect(@full_quarter * @p).to eq Point.new(x, y, z)
end

Given('inv ← inverse\(half_quarter)') do
  @inv = @half_quarter.inverse
end

Then('inv * p = point\({int}, √2\/{int}, -√2\/{int})') do |int, int2, int3|
  x = int
  y = Math.sqrt(2 / int2)
  z = Math.sqrt(2 / int3) * -1
  expect(@inv * @p).to eq Point.new(x, y, z)
end
