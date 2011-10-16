class Player < GameObject
  @image_filename = "images/ship.png"

  def initialize(window, x, y)
    super(window, x, y)
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

