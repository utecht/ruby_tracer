class Light
  attr_reader :intensity, :position
  def ==(other)
    @position == other.position and @intensity == other.intensity
  end

end

class PointLight < Light

  def initialize(position, intensity)
    @position = position
    @intensity = intensity
  end
end
