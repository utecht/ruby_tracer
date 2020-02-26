require 'geometry'

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
