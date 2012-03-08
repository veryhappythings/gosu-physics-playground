class Rock < GameObject
  @image_filename = "images/ship.png"

  @shape_array = [
      CP::Vec2.new(-25, -25),
      CP::Vec2.new(-25, 25),
      CP::Vec2.new(25, 25),
      CP::Vec2.new(25, -25),
    ]

  def initialize(window, x, y)
    super(window, x, y)
    # Limit velocity
    @shape.body.w_limit = 0.3
  end

  # Wrap to the other side of the screen when we fly off the edge
  def validate_position
    @shape.body.p = CP::Vec2.new(@shape.body.p.x % @window.width, @shape.body.p.y % @window.height)
  end

  def update(dt)
    super(dt)
    validate_position
  end
end

