require_relative './geometry'
require_relative './transform'
require_relative './light'

class World
  attr_accessor :objects, :light

  def self.default_world()
    light = PointLight.new(Point.new(-10, 10, -10), Color.new(1, 1, 1))
    s1 = Sphere.new
    material = Material.new
    material.color = Color.new(0.8, 1.0, 0.6)
    material.diffuse = 0.7
    material.specular = 0.2
    s1.material = material
    s2 = Sphere.new
    s2.set_transform(Transform.scaling(0.5, 0.5, 0.5))
    w = World.new
    w.objects = [s1, s2]
    w.light = light
    return w
  end

  def initialize()
  end

  def intersect_world(ray)
    intersections = []
    @objects.each do |object|
      ints = object.intersect(ray)
      ints.data.each do |i|
        intersections.append(i)
      end
    end
    sorted = intersections.sort {|a,b| a.t <=> b.t}
    return Intersections.new(*sorted)
  end

  def shade_hit(comp)
    comp.object.material.lighting(@light, comp.point, comp.eyev, comp.normalv)
  end

  def color_at(ray)
    hit = intersect_world(ray).hit
    return Color.Black if hit.nil?
    comps = hit.prepare_computations(ray)
    shade_hit(comps)
  end
end
