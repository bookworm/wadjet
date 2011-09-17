class Size
  attr_reader :width, :height 
  attr_writer :width, :height
  
  def self.to_mongo(value)
    value.to_a
  end

  def self.from_mongo(value)
    value.is_a?(self) ? value : Size.new(value)
  end

  def initialize(*args)
    @width, @height = args.flatten
  end

  def to_a
    [width, height]
  end

  def ==(other)
    other.is_a?(self.class) && other.width == width && other.height == height
  end
end