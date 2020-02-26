require 'geometry'

When('i ← intersection\({float}, s)') do |float|
  @i = Intersection.new(float, @s)
end

Then('i.t = {float}') do |float|
  expect(@i.t).to eq float
end

Then('i.object = s') do
  expect(@i.object).to eq @s
end

Given('i1 ← intersection\({float}, s)') do |float|
  @i1 = Intersection.new(float, @s)
end

Given('i2 ← intersection\({float}, s)') do |float|
  @i2 = Intersection.new(float, @s)
end

When('xs ← intersections\(i1, i2)') do
  @xs = Intersections.new(@i1, @i2)
end

Then('xs[{int}].t = {float} And xs[{int}].t = {float}') do |int, float, int2, float2|
  expect(@xs[int].t).to eq float
  expect(@xs[int2].t).to eq float2
end

Then('xs[{int}].object = s') do |int|
  expect(@xs[int].object).to eq @s
end

Given('xs ← intersections\(i2, i1)') do
  @xs = Intersections.new(@i2, @i1)
end

When('i ← hit\(xs)') do
  @i = @xs.hit
end

Then('i = i1') do
  expect(@i).to eq @i1
end

Then('i = i2') do
  expect(@i).to eq @i2
end

Then('i is nothing') do
  expect(@i).to be nil
end

Given('i3 ← intersection\({float}, s)') do |float|
  @i3 = Intersection.new(float, @s)
end

Given('i4 ← intersection\({float}, s)') do |float|
  @i4 = Intersection.new(float, @s)
end

Given('xs ← intersections\(i1, i2, i3, i4)') do
  @xs = Intersections.new(@i1, @i2, @i3, @i4)
end

Then('i = i4') do
  expect(@i).to eq @i4
end
