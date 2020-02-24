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
    @matrix = Matrix.new(4)
    @matrix[0, 0] = x
    @matrix[1, 1] = y
    @matrix[2, 2] = z
    @matrix[3, 3] = 1
    return @matrix
  end

  def self.rotation_x(radians)
  end
end
