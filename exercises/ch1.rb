require '../lib/tuple'

class Projectile
  attr_reader :position, :velocity

  def initialize(pos, vel, env)
    @position = pos
    @velocity = vel
    @env = env
  end

  def tick
    @position = @position + @velocity
    @velocity = @velocity + @env.gravity + @env.wind
  end

end

class Environment
  attr_reader :gravity, :wind

  def initialize(grav, wind)
    @gravity = grav
    @wind = wind
  end
end

environment = Environment.new(Vector.new(0, -0.1, 0), Vector.new(-0.01, 0, 0))
projectile = Projectile.new(Point.new(0, 0, 0), Vector.new(1, 1, 0).normalize, environment)

25.times do
  projectile.tick
  puts projectile.position.inspect
end

puts projectile.position.inspect
