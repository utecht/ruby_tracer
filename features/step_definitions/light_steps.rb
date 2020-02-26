require 'tuple'
require 'light'

Given('intensity ← color\({float}, {float}, {float})') do |r, g, b|
  @intensity = Color.new(r, g, b)
end

Given('position ← point\({float}, {float}, {float})') do |x, y, z|
  @position = Point.new(x, y, z)
end

When('light ← point_light\(position, intensity)') do
  @light = PointLight.new(@position, @intensity)
end

Then('light.position = position') do
  expect(@light.position).to eq @position
end

Then('light.intensity = intensity') do
  expect(@light.intensity).to eq @intensity
end
