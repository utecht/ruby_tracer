EPSILON = 0.0001

def close_enough(a, b)
  (a - b).abs < EPSILON
end

class Tuple
  attr_accessor :x, :y, :z, :w

  def initialize(x, y, z, w)
    @x = x.to_f
    @y = y.to_f
    @z = z.to_f
    @w = w.to_f
  end

  def point?
    @w == 1
  end

  def vector?
    @w == 0
  end

  def magnitude
    m = @x ** 2 + @y ** 2 + @z ** 2 + @w ** 2
    Math.sqrt(m)
  end

  def normalize
    m = self.magnitude
    x = @x / m
    y = @y / m
    z = @z / m
    w = @w / m
    Tuple.new(x, y, z, w)
  end

  def dot(b)
    @x * b.x + @y * b.y + @z * b.z + @w * b.w
  end

  def cross(b)
    x = @y * b.z - @z * b.y
    y = @z * b.x - @x * b.z
    z = @x * b.y - @y * b.x
    Vector.new(x, y, z)
  end

  def reflect(normal)
    self - normal * 2 * self.dot(normal)
  end

  def +(other)
    x = @x + other.x
    y = @y + other.y
    z = @z + other.z
    w = @w + other.w
    Tuple.new(x, y, z, w)
  end

  def *(val)
    x = @x * val
    y = @y * val
    z = @z * val
    w = @w * val
    Tuple.new(x, y, z, w)
  end

  def /(val)
    x = @x / val
    y = @y / val
    z = @z / val
    w = @w / val
    Tuple.new(x, y, z, w)
  end

  def -(other)
    x = @x - other.x
    y = @y - other.y
    z = @z - other.z
    w = @w - other.w
    Tuple.new(x, y, z, w)
  end

  def -@
    x = 0 - @x
    y = 0 - @y
    z = 0 - @z
    w = 0 - @w
    Tuple.new(x, y, z, w)
  end

  def ==(other)
    close_enough(@x, other.x) && close_enough(@y, other.y) && close_enough(@z, other.z) && close_enough(@w, other.w)
  end
end

class Vector < Tuple
  def initialize(x, y, z)
    super(x, y, z, 0)
  end
end

class Point < Tuple
  def initialize(x, y, z)
    super(x, y, z, 1)
  end
end

class Color < Tuple
  def self.Black
    Color.new(0, 0, 0)
  end

  def initialize(r, g, b)
    super(r, g, b, 0)
  end

  def red
    @x
  end

  def green
    @y
  end

  def blue
    @z
  end

  def *(other)
    unless other.is_a?(Color)
      return super
    end
    r = self.red * other.red
    g = self.green * other.green
    b = self.blue * other.blue
    Color.new(r, g, b)
  end
end
