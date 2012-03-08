class Player < GameObject
  @image_filename = "images/ship.png"

  def initialize(window, x, y)
    super(window, x, y)
    # Limit velocity
    @shape.body.w_limit = 0.3
  end

  def turn_left
    @shape.body.t -= GameObject::TURNSPEED/Physics::SUBSTEPS
  end

  def turn_right
    @shape.body.t += GameObject::TURNSPEED/Physics::SUBSTEPS
  end

  def accelerate
    @shape.body.apply_force((@shape.body.a.radians_to_vec2 * (GameObject::ACCERATION/Physics::SUBSTEPS)), CP::Vec2.new(0.0, 0.0))
  end

  def decelerate
    @shape.body.apply_force((-(@shape.body.a.radians_to_vec2) * (GameObject::ACCERATION/Physics::SUBSTEPS)), CP::Vec2.new(0.0, 0.0))
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

