class Rock < GameObject
  @shape_array = [
      CP::Vec2.new(-15, -15),
      CP::Vec2.new(-15, 15),
      CP::Vec2.new(15, 15),
      CP::Vec2.new(15, -15),
    ]
  @mass = 5.0

  def initialize(window, x, y)
    super(window, x, y)
    # Limit velocity
    @shape.body.w_limit = 0.3
    @width = @height = 30
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

