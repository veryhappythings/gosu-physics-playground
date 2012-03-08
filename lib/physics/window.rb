class Window < Gosu::Window
  attr_reader :objects
  attr_reader :space

  def initialize()
    super(640, 480, false)
    self.caption = 'Physics!'

    @space = CP::Space.new
    @space.damping = 0.8

    @player = Player.new(self, 100, 100)
    @rock = Rock.new(self, 300, 300)
    @objects = [
      @player,
    ]
    (1..30).each do |i|
      @objects << Rock.new(self, rand(640), rand(480))
    end

    @dt = (1.0/60.0)
    @time_to_reload = 0
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
        @player.decelerate
      end
      if button_down? Gosu::Button::KbLeft
        @player.turn_left
      end
      if button_down? Gosu::Button::KbRight
        @player.turn_right
      end
      @space.step(@dt)
    end

#    @time_to_reload += 1
#    if @time_to_reload > 60
#      @time_to_reload = 0
#      begin
#        root = File.dirname(File.expand_path(__FILE__))
#        load "#{root}/models/player.rb"
#        load "#{root}/lib/game_object.rb"
#      rescue
#      end
#    end
  end

  def button_down(id)
    if id == Gosu::Button::KbEscape
      close
    end
  end
end
