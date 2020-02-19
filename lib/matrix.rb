require_relative './tuple'

class Matrix
  attr_reader :data

  def self.from_data_table(data)
    height = data.length
    width = data[0].length
    m = Matrix.new(height, width)
    width.times do |x|
      height.times do |y|
        m[x, y] = data[x][y].to_f
      end
    end
    return m
  end

  def self.identity
    m = Matrix.new(4, 4)
    m[0,0] = 1
    m[1,1] = 1
    m[2,2] = 1
    m[3,3] = 1
    return m
  end

  def initialize(width, height)
    @height = height
    @width = width
    @data = Array.new(@width * @height, 0)
  end

  def [](x, y)
    @data[(y * @width) + x]
  end

  def []=(x, y, val)
    @data[(y * @width) + x] = val
  end

  def ==(other)
    @data == other.data
    @width.times do |row|
      @height.times do |col|
        return false unless close_enough(self[row, col], other[row, col])
      end
    end
    true
  end

  def *(b)
    if b.is_a?(Tuple)
      return tuple_mult(b)
    end
    m = Matrix.new(@width, @height)
    @width.times do |row|
      @height.times do |col|
        val = 0
        @width.times do |x|
          val += self[row, x] * b[x, col]
        end
        m[row, col] = val
      end
    end
    return m
  end

  def tuple_mult(t)
    b = [t.x, t.y, t.z, t.w]
    m = Array.new(4)
    @width.times do |row|
      val = 0
      @width.times do |x|
        val += self[row, x] * b[x]
      end
      m[row] = val
    end
    Tuple.new(m[0], m[1], m[2], m[3])
  end

  def transpose
    m = Matrix.new(@width, @height)
    @width.times do |row|
      @height.times do |col|
        m[col, row] = self[row, col]
      end
    end
    return m
  end

  def determinant
    size = @width
    if size == 2
      return (self[0,0] * self[1,1]) - (self[0,1] * self[1,0])
    end
    det = 0
    size.times do |col|
      det += self[0, col] * cofactor(0, col)
    end
    return det
  end

  def submatrix(skip_row, skip_col)
    m = Matrix.new(@width - 1, @height - 1)
    x = 0
    @width.times do |row|
      y = 0
      unless row == skip_row
        @height.times do |col|
          unless col == skip_col
            m[x, y] = self[row, col]
            y += 1
          end
        end
        x += 1
      end
    end
    return m
  end

  def minor(row, col)
    submatrix(row, col).determinant
  end

  def cofactor(row, col)
    cf = minor(row, col)
    if (row + col) % 2 == 1
      return cf * -1
    end
    cf
  end

  def invertable?
    determinant != 0
  end

  def inverse
    return nil unless invertable?

    m = Matrix.new(@width, @height)

    @width.times do |row|
      @height.times do |col|
        c = cofactor(row, col)
        m[col, row] = c / determinant
      end
    end
    return m
  end

end
