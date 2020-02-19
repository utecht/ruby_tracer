require '../lib/tuple'
require '../lib/png_canvas'

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

environment = Environment.new(Vector.new(0, -0.1, 0),
                              Vector.new(-0.01, 0, 0))
projectile = Projectile.new(Point.new(0, 0, 0),
                            Vector.new(1.0, 2, 0).normalize * 10,
                            environment)
canvas = PNG_Canvas.new(500, 500)
red = Color.new(1.0, 0.0, 0.0)

125.times do
  projectile.tick
  canvas.write_pixel(projectile.position.x.floor,
                     canvas.height - projectile.position.y.floor,
                     red)
end

canvas.write_png("test.png")
