class ToyRobot
  private

  START_LIMIT = 0
  END_LIMIT = 4
  FACE_MAP = { 'NORTH' => 0, 'EAST' => 1, 'SOUTH' => 2, 'WEST' => 3 }

  def initialize
    @position = [0, 0]
    @face = 0
  end

  def place(x, y, f)
    x = x.to_i
    y = y.to_i
    f = f.upcase

    return 'Invalid Position!' unless (x >= START_LIMIT && x <= END_LIMIT) &&
                                      (y >= START_LIMIT && y <= END_LIMIT)
    return 'Invalid Face!' unless FACE_MAP[f]

    @position = [x, y]
    @face = FACE_MAP[f]

    report
  end

  def move
    case @face
    when 0
      @position[1] -= 1 if @position[1] > START_LIMIT
    when 1
      @position[0] += 1 if @position[0] < END_LIMIT
    when 2
      @position[1] += 1 if @position[1] < END_LIMIT
    when 3
      @position[0] -= 1 if @position[0] > START_LIMIT
    else
      puts 'Invalid face!'
    end
    
    report
  end

  def left
    @face -= 1
    @face = 3 if @face < 0
    report
  end

  def right
    @face += 1
    @face = 0 if @face > 3
    report
  end

  def report
    puts "POSITION: [#{@position[0]}, #{@position[1]}], FACE: #{FACE_MAP.key(@face)}"
    { position: @position, face: @face }
  end

  public

  def self.cli
    ToyRobot.new.cli
  end

  def cli
    while true
      command = gets
      exec_command(command)
    end
  end

  def exec_command(command)
    command.strip!
    command, args = command.split(' ')
    args = args&.split(',')
    send(command.downcase, *args)
  rescue => e
    return 'Invalid Command!'
  end
end
