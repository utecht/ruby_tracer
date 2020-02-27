require_relative './matrix'
require_relative './material'

class Sphere
  attr_reader :transform
  attr_accessor :material

  def initialize
    @transform = Matrix.identity
    @material = Material.new
  end

  def intersect(ray)
    ray = ray.transform(@transform.inverse)
    sphere_to_ray = ray.origin - Point.new(0, 0, 0)

    a = ray.direction.dot(ray.direction)
    b = ray.direction.dot(sphere_to_ray) * 2
    c = sphere_to_ray.dot(sphere_to_ray) - 1

    discriminant = (b ** 2) - 4 * a * c

    return Intersections.new if discriminant < 0
    t1 = (-b - Math.sqrt(discriminant)) / (2 * a)
    t2 = (-b + Math.sqrt(discriminant)) / (2 * a)
    Intersections.new(Intersection.new(t1, self), Intersection.new(t2, self))
  end

  def set_transform(t)
    @transform = t * @transform
  end

  def normal_at(point)
    object_point = @transform.inverse * point
    object_normal = object_point - Point.new(0, 0, 0)
    world_normal = @transform.inverse.transpose * object_normal
    world_normal.w = 0.0
    return world_normal.normalize
  end

  def ==(other)
    @transform == other.transform and @material == other.material
  end
end

class Intersection
  attr_reader :t, :object

  def initialize(t, object)
    @t = t
    @object = object
  end

  def prepare_computations(ray)
    Computations.new(@t, @object, ray)
  end

  def ==(other)
    if other.is_a?(Intersection)
      return @t == other.t
    end
    @t == other
  end
end

class Intersections
  attr_reader :data

  def initialize(*intersections)
    @data = Array.new(intersections)
  end

  def hit
    lowest_t = Float::INFINITY
    best_hit = nil
    @data.each do |intersection|
      if intersection.t >= 0 and intersection.t < lowest_t
        lowest_t = intersection.t
        best_hit = intersection
      end
    end
    return best_hit
  end

  def [](i)
    @data[i]
  end

  def count
    @data.count
  end
end

class Computations
  attr_reader :t, :object, :point, :eyev, :normalv, :inside

  def initialize(t, object, ray)
    @t = t
    @object = object
    @point = ray.position(t)
    @eyev = -ray.direction
    @normalv = object.normal_at(@point)
    if @normalv.dot(@eyev) < 0
      @inside = true
      @normalv = -@normalv
    else
      @inside = false
    end
  end
end
