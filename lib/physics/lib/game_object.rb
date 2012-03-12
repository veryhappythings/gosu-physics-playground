class GameObject
  include InheritableAttributes
  TURNSPEED = 20000
  ACCERATION = 3000

  inheritable_attributes :mass, :inertia, :shape_array, :collision_type
  # Anti-clockwise
  # Points to the right, because in radians, 0 degrees points right.
  @shape_array = [
      CP::Vec2.new(25, 0),
      CP::Vec2.new(-25, -25),
      CP::Vec2.new(-25, 25),
    ]
  @mass = 50.0
  @collision_type = :ship

  attr_reader :shape, :height, :width

  def initialize(window, x, y)
    @window = window

    # Bodies init with mass and inertia
    body = CP::Body.new(
      self.class.mass,
      CP.moment_for_poly(self.class.mass, self.class.shape_array, CP::Vec2.new(0, 0))
    )

    @shape = CP::Shape::Poly.new(body, self.class.shape_array, CP::Vec2.new(0,0))
    @shape.collision_type = self.class.collision_type

    @shape.body.p = CP::Vec2.new(x, y) # position
    @shape.body.v = CP::Vec2.new(0.0, 0.0) # velocity
    @shape.body.a = 0.gosu_to_radians
    @shape.body.object = self # This allows you to access this object in collisions

    @window.space.add_body(body)
    @window.space.add_shape(shape)

    @height = 10
    @width = 10
  end

  def warp(vect)
    @shape.body.p = vect
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

  def draw
    draw_bounding_box
  end

  def update(dt)
    @shape.body.reset_forces
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

  # Debug function to draw bounding box
  def draw_bounding_box
    # Draw the bounding box of the shape
#    top_left, top_right, bottom_left, bottom_right = self.rotate
#    @window.draw_quad(
#      top_left.x, top_left.y, Colours::RED,
#      top_right.x, top_right.y, Colours::RED,
#      bottom_left.x, bottom_left.y, Colours::RED,
#      bottom_right.x, bottom_right.y, Colours::RED,
#      z=0
#    )

    # Draw a wireframe of the shape
    self.class.shape_array.each_with_index do |vector, i|
      prev = self.class.shape_array[i-1]
      @window.translate(@shape.body.p.x, @shape.body.p.y) do
        @window.rotate(@shape.body.a.radians_to_degrees, 0, 0) do
          @window.draw_line(
            prev.x,
            prev.y,
            Colours::WHITE,
            vector.x,
            vector.y,
            Colours::WHITE
          )
        end
      end
    end

    # Draw a dot in the middle of the shape
    @window.draw_quad(
        @shape.body.p.x, @shape.body.p.y, Colours::WHITE,
        @shape.body.p.x+1, @shape.body.p.y, Colours::WHITE,
        @shape.body.p.x+1, @shape.body.p.y+1, Colours::WHITE,
        @shape.body.p.x, @shape.body.p.y+1, Colours::WHITE
    )
  end

  # Return the 4 corners of the bounding box that contains this object
  def rotate
    half_diagonal = Math.sqrt(2) * (self.width/2)
    [-45, +45, -135, +135].collect do |angle|
      CP::Vec2.new(@shape.body.p.x + Gosu::offset_x(@shape.body.a.radians_to_gosu + angle,
                                              half_diagonal),

                   @shape.body.p.y + Gosu::offset_y(@shape.body.a.radians_to_gosu + angle,
                                              half_diagonal))
    end
  end
end
