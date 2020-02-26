class Light
  attr_reader :intensity, :position

end

class PointLight < Light

  def initialize(position, intensity)
    @position = position
    @intensity = intensity
  end
end
