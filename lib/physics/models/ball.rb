class Ball < GameObject
  def self.image_filename
    "images/ball.png"
  end

  attr_accessor :x, :y

  def initialize(window, x, y)
    super
    @vx, @vy = 5, 5
  end

  def update(dt)
    @x += @vx
    @y += @vy

    if @y <= 0 || @y >= @window.height - self.height
      @vy = -@vy
    end

    if @x <= 0 || @x >= @window.width - self.width
      @vx = -@vx
    end

    @window.objects.each do |object|
      if self.collides_with? object
        object.notify(:collision, object => self)
        @vx = -@vx
      end
    end
  end
end
