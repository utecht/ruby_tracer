require 'canvas'
require 'tuple'

Given('c ← canvas\({int}, {int})') do |w, h|
  @c = Canvas.new(w, h)
end

Then('c.width = {int}') do |int|
  expect(@c.width).to eq int
end

Then('c.height = {int}') do |int|
  expect(@c.height).to eq int
end

Then('every pixel of c is color\({float}, {float}, {float})') do |r, g, b|
  color = Color.new(r, g, b)
  @c.width.times do |w|
    @c.height.times do |h|
      expect(@c.pixel_at(w, h)).to eq color
    end
  end
end

Given('red ← color\({float}, {float}, {float})') do |r, g, b|
  @red = Color.new(r, g, b)
end

When('write_pixel\(c, {int}, {int}, red)') do |x, y|
  @c.write_pixel(x, y, @red)
end

Then('pixel_at\(c, {int}, {int}) = red') do |x, y|
  expect(@c.pixel_at(x, y)).to eq @red
end

When('ppm ← canvas_to_ppm\(c)') do
  @ppm = @c.canvas_to_ppm
end

Then('lines {int}-{int} of ppm are') do |i, i2, string|
  i -= 1
  i2 -= 1
  expect(@ppm.lines(chomp: true)[i..i2].join("\n")).to eq string
end

Given('c3 ← color\({float}, {float}, {float})') do |r, g, b|
  @c3 = Color.new(r, g, b)
end

When('write_pixel\(c, {int}, {int}, c1)') do |x, y|
  @c.write_pixel(x, y, @c1)
end

When('write_pixel\(c, {int}, {int}, c2)') do |x, y|
  @c.write_pixel(x, y, @c2)
end

When('write_pixel\(c, {int}, {int}, c3)') do |x, y|
  @c.write_pixel(x, y, @c3)
end

When('every pixel of c is set to color\({float}, {float}, {float})') do |r, g, b|
  color = Color.new(r, g, b)
  @c.width.times do |w|
    @c.height.times do |h|
      @c.write_pixel(w, h, color)
    end
  end
end

Then('ppm ends with a newline character') do
  expect(@ppm.end_with?("\n")).to be true
end

Then('write_pixel\(c, {int}, {int}, red) should not crash') do |int, int2|
  expect{
    @c.write_pixel(int, int2, @red)}.not_to raise_error
end
