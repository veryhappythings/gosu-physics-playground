class GameObject
  TURNSPEED = 4.5
  attr_reader :x, :y
  def self.image_filename
    "images/paddle.png"
  end

  def initialize(window, x, y)
    @window = window
    @image = Gosu::Image.new(@window, self.class.image_filename)
    @x = x
    @y = y
    @vx = 0
    @vy = 0
    @angle = 0
  end

  def warp(x, y)
    @x = x
    @y = y
  end

  def height
    @image.height
  end

  def width
    @image.width
  end

  def top
    @y
  end

  def bottom
    @y + height
  end

  def left
    @x
  end

  def right
    @x + width
  end

  def turn_left
    @angle -= GameObject::TURNSPEED
  end

  def turn_right
    @angle += GameObject::TURNSPEED
  end

  def accelerate
    @vx += Gosu::offset_x(@angle, 0.5)
    @vy += Gosu::offset_y(@angle, 0.5)
  end

  def draw
    @image.draw_rot @x, @y, 1, @angle
  end

  def update(dt)
    @x += @vx
    @y += @vy

    @x %= 640
    @y %= 480

    @vx *= 0.95
    @vy *= 0.95
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
