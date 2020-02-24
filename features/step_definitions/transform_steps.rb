require 'transform'
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

Given('half_quarter ← rotation_x\(π / {float})') do |float|
  @half_quarter = Transform.rotation_x(Math::PI / float)
end

Given('full_quarter ← rotation_x\(π / {float})') do |float|
  @full_quarter = Transform.rotation_x(Math::PI / float)
end

Then('half_quarter * p = point\({int}, √2\/{int}, √2\/{int})') do |int, int2, int3|
  x = int
  y = Math.sqrt(2) / int2
  z = Math.sqrt(2) / int3
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
  y = Math.sqrt(2) / int2
  z = -Math.sqrt(2) / int3
  expect(@inv * @p).to eq Point.new(x, y, z)
end

Given('half_quarter ← rotation_y\(π / {float})') do |float|
  @half_quarter = Transform.rotation_y(Math::PI / float)
end

Given('full_quarter ← rotation_y\(π / {float})') do |float|
  @full_quarter = Transform.rotation_y(Math::PI / float)
end

Then('half_quarter * p = point\(√2\/{int}, {int}, √2\/{int})') do |int, int2, int3|
  x = Math.sqrt(2) / int
  y = int2
  z = Math.sqrt(2) / int3
  expect(@half_quarter * @p).to eq Point.new(x, y, z)
end


Given('half_quarter ← rotation_z\(π / {float})') do |float|
  @half_quarter = Transform.rotation_z(Math::PI / float)
end

Given('full_quarter ← rotation_z\(π / {float})') do |float|
  @full_quarter = Transform.rotation_z(Math::PI / float)
end

Then('half_quarter * p = point\(-√2\/{int}, √2\/{int}, {int})') do |int, int2, int3|
  x = -Math.sqrt(2) / int
  y = Math.sqrt(2) / int2
  z = int3
  expect(@half_quarter * @p).to eq Point.new(x, y, z)
end

Given('transform ← shearing\({float}, {float}, {float}, {float}, {float}, {float})') do |float, float2, float3, float4, float5, float6|
  @transform = Transform.shearing(float, float2, float3, float4, float5, float6)
end

Given('A ← rotation_x\(π / {float})') do |float|
  @A = Transform.rotation_x(Math::PI / float)
end

Given('B ← scaling\({float}, {float}, {float})') do |x, y, z|
  @B = Transform.scaling(x, y, z)
end

Given('C ← translation\({float}, {float}, {float})') do |x, y, z|
  @C = Transform.translation(x, y, z)
end

When('p2 ← A * p') do
  @p2 = @A * @p
end

Then('p2 = point\({float}, {float}, {float})') do |x, y, z|
  expect(@p2).to eq Point.new(x, y, z)
end

When('p3 ← B * p2') do
  @p3 = @B * @p2
end

Then('p3 = point\({float}, {float}, {float})') do |x, y, z|
  expect(@p3).to eq Point.new(x, y, z)
end

Then('p4 = point\({float}, {float}, {float})') do |x, y, z|
  expect(@p4).to eq Point.new(x, y, z)
end

When('T ← C * B * A') do
  @T = @C * @B * @A
end

Then('T * p = point\({float}, {float}, {float})') do |x, y, z|
  expect(@T * @p).to eq Point.new(x, y, z)
end

When('p4 ← C * p3') do
  @p4 = @C * @p3
end
