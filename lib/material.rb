require_relative './tuple'

class Material
  attr_accessor :color, :ambient, :diffuse, :specular, :shininess

  def initialize
    @color = Color.new(1, 1, 1)
    @ambient = 0.1
    @diffuse = 0.9
    @specular = 0.9
    @shininess = 200.0
  end

  def lighting(light, point, eyev, normalv)
    effective_color = @color * light.intensity
    lightv = (light.position - point).normalize
    ambient = effective_color * @ambient
    light_dot_normal = lightv.dot(normalv)
    if light_dot_normal < 0
      diffuse = Color.Black
      specular = Color.Black
    else
      diffuse = effective_color * @diffuse * light_dot_normal
      reflectv = -lightv.reflect(normalv)
      reflect_dot_eye = reflectv.dot(eyev)
      if reflect_dot_eye <= 0
        specular = Color.Black
      else
        factor = reflect_dot_eye ** @shininess
        specular = light.intensity * @specular * factor
      end
    end
    t = ambient + diffuse + specular
    Color.new(t.x, t.y, t.z)
  end
end
