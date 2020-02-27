require 'world'
require 'transform'

Given(/w ← world\(\)/) do
  @w = World.new
end

Then('w contains no objects') do
  expect(@w.objects).to be nil
end

Then('w has no light source') do
  expect(@w.light).to be nil
end

Given(/s1 ← sphere\(\) with:/) do |table|
  @s1 = Sphere.new
  material = Material.new
  material.color = Color.new(0.8, 1.0, 0.6)
  material.diffuse = 0.7
  material.specular = 0.2
  @s1.material = material
end

Given(/s2 ← sphere\(\) with:/) do |table|
  @s2 = Sphere.new
  @s2.set_transform(Transform.scaling(0.5, 0.5, 0.5))
end

When(/w ← default_world\(\)/) do
  @w = World.default_world
end

Then('w.light = light') do
  expect(@w.light).to eq @light
end

Then('w contains s1') do
  expect(@w.objects).to include @s1
end

Then('w contains s2') do
  expect(@w.objects).to include @s2
end

When('xs ← intersect_world\(w, r)') do
  @xs = @w.intersect_world(@r)
end

Given('shape ← the first object in w') do
  @shape = @w.objects[0]
end

When('c ← shade_hit\(w, comps)') do
  @c = @w.shade_hit(@comps)
  require 'pp'
  puts pp @comps
  puts pp @w
end

Then('c = color\({float}, {float}, {float})') do |r, g, b|
  expect(@c).to eq Color.new(r, g, b)
end

Given('shape ← the second object in w') do
  @shape = @w.objects[1]
end

When('c ← color_at\(w, r)') do
  @c = @w.color_at(@r)
end

Given('outer ← the first object in w') do
  @outer = @w.objects[0]
end

Given('outer.material.ambient ← {float}') do |float|
  @outer.material.ambient = float
end

Given('inner ← the second object in w') do
  @inner = @w.objects[1]
end

Given('inner.material.ambient ← {float}') do |float|
  @inner.material.ambient = float
end

Then('c = inner.material.color') do
  expect(@c).to eq @inner.material.color
end
