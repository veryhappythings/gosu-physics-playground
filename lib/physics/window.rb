class Window < Gosu::Window
  attr_reader :objects
  def initialize()
    super(640, 480, false)
    caption = 'Physics!'

    @current_time = Gosu::milliseconds
    @player = Player.new(self, 50, 10)
    @objects = [@player]
  end

  def draw
    @objects.each do |object|
      object.draw
    end
  end

  def update
    dt = (Gosu::milliseconds - @current_time) / 1000.0
    @current_time = Gosu::milliseconds

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

    @objects.each do |object|
      object.update(dt)
    end
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
end
