require_relative './tuple'

class Ray
  attr_reader :origin, :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def position(t)
    @origin + @direction * t
  end

  def transform(t)
    new_origin = t * @origin
    new_direction = t * @direction
    Ray.new(new_origin, new_direction)
  end

end
