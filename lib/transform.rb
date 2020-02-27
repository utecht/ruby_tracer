require_relative './matrix'

class Transform

  def self.translation(x, y, z)
    @matrix = Matrix.new(4)
    @matrix[0, 0] = 1
    @matrix[1, 1] = 1
    @matrix[2, 2] = 1
    @matrix[3, 3] = 1
    @matrix[0, 3] = x
    @matrix[1, 3] = y
    @matrix[2, 3] = z
    return @matrix
  end

  def self.scaling(x, y, z)
    raise RuntimeError if x == 0 or y == 0 or z == 0
    @matrix = Matrix.new(4)
    @matrix[0, 0] = x
    @matrix[1, 1] = y
    @matrix[2, 2] = z
    @matrix[3, 3] = 1
    return @matrix
  end

  def self.rotation_x(radians)
    @matrix = Matrix.new(4)
    @matrix[0, 0] = 1
    @matrix[1, 1] = Math.cos(radians)
    @matrix[2, 1] = Math.sin(radians)
    @matrix[1, 2] = -Math.sin(radians)
    @matrix[2, 2] = Math.cos(radians)
    @matrix[3, 3] = 1
    return @matrix
  end

  def self.rotation_y(radians)
    @matrix = Matrix.new(4)
    @matrix[0, 0] = Math.cos(radians)
    @matrix[1, 1] = 1
    @matrix[0, 2] = Math.sin(radians)
    @matrix[2, 0] = -Math.sin(radians)
    @matrix[2, 2] = Math.cos(radians)
    @matrix[3, 3] = 1
    return @matrix
  end

  def self.rotation_z(radians)
    @matrix = Matrix.new(4)
    @matrix[0, 0] = Math.cos(radians)
    @matrix[1, 1] = Math.cos(radians)
    @matrix[0, 1] = -Math.sin(radians)
    @matrix[1, 0] = Math.sin(radians)
    @matrix[2, 2] = 1
    @matrix[3, 3] = 1
    return @matrix
  end

  def self.shearing(xy, xz, yx, yz, zx, zy)
    @matrix = Matrix.new(4)
    @matrix[0, 0] = 1
    @matrix[0, 1] = xy
    @matrix[1, 0] = yx
    @matrix[1, 1] = 1
    @matrix[0, 2] = xz
    @matrix[2, 0] = zx
    @matrix[1, 2] = yz
    @matrix[2, 1] = zy
    @matrix[2, 2] = 1
    @matrix[3, 3] = 1
    return @matrix
  end

  def self.view_transform(from, to, up)
    @matrix = Matrix.new(4)
    forward = (to - from).normalize
    left = forward.cross(up.normalize)
    true_up = left.cross(forward)
    @matrix[0, 0] = left.x
    @matrix[0, 1] = left.y
    @matrix[0, 2] = left.z
    @matrix[1, 0] = true_up.x
    @matrix[2, 0] = -forward.x
    @matrix[1, 1] = true_up.y
    @matrix[2, 1] = -forward.y
    @matrix[1, 2] = true_up.z
    @matrix[2, 2] = -forward.z
    @matrix[3, 3] = 1
    return @matrix * Transform.translation(-from.x, -from.y, -from.z)
  end
end
