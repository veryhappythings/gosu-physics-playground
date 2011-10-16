class GameObject
  attr_reader :shape

  def self.image_filename
    "images/paddle.png"
  end

  def initialize(window, x, y)
    @window = window
    @image = Gosu::Image.new(@window, self.class.image_filename)

    body = CP::Body.new(10.0, 150.0)
    shape_array = [
      CP::Vec2.new(-25.0, -25.0),
      CP::Vec2.new(-25.0, 25.0),
      CP::Vec2.new(25.0, 1.0),
      CP::Vec2.new(25.0, -1.0)
    ]
    @shape = CP::Shape::Poly.new(body, shape_array, CP::Vec2.new(0,0))
    @shape.collision_type = :ship

    @shape.body.p = CP::Vec2.new(0.0, 0.0) # position
    @shape.body.v = CP::Vec2.new(0.0, 0.0) # velocity
    @shape.body.a = (3*Math::PI/2.0) # angle in radians; faces towards top of screen

    @window.space.add_body(body)
    @window.space.add_shape(shape)
  end

  def warp(vect)
    @shape.body.p = vect
  end

  def height
    @image.height
  end

  def width
    @image.width
  end

  def top
    @shape.body.p.y
  end

  def bottom
    @shape.body.p.y + height
  end

  def left
    @shape.body.p.x
  end

  def right
    @shape.body.p.x + width
  end

  def turn_left
    @shape.body.t -= 400.0/Physics::SUBSTEPS
  end

  def turn_right
    @shape.body.t += 400.0/Physics::SUBSTEPS
  end

  def accelerate
    @shape.body.apply_force((@shape.body.a.radians_to_vec2 * (3000.0/Physics::SUBSTEPS)), CP::Vec2.new(0.0, 0.0))
  end

  def draw
    @image.draw_rot(@shape.body.p.x, @shape.body.p.y, 1, @shape.body.a.radians_to_gosu)
  end

  def update(dt)
    @shape.body.reset_forces
    validate_position
  end

  # Wrap to the other side of the screen when we fly off the edge
  def validate_position
    @shape.body.p = CP::Vec2.new(@shape.body.p.x % @window.width, @shape.body.p.y % @window.height)
  end


  def collides_with? other
    if not other.kind_of? GameObject
      false
    elsif other == self
      false
    else
      !(bottom < other.top ||
        top > other.bottom ||
        right < other.left ||
        left > other.right)
    end
  end

  def notify(message, options={})

  end
end
