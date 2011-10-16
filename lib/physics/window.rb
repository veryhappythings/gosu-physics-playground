class Window < Gosu::Window
  attr_reader :objects
  attr_reader :space

  def initialize()
    super(640, 480, false)
    self.caption = 'Physics!'

    @space = CP::Space.new
    @space.damping = 0.8

    @player = Player.new(self, 50, 10)
    @objects = [@player]

    @dt = (1.0/60.0)
  end

  def draw
    @objects.each do |object|
      object.draw
    end
  end

  def update
    Physics::SUBSTEPS.times do
      @objects.each do |object|
        object.update(@dt)
      end

      if button_down? Gosu::Button::KbUp
        @player.accelerate
      end
      if button_down? Gosu::Button::KbDown
        #@player.y += 10
      end
      if button_down? Gosu::Button::KbLeft
        @player.turn_left
      end
      if button_down? Gosu::Button::KbRight
        @player.turn_right
      end
      @space.step(@dt)
    end
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
end
