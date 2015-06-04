class KeyCreator

  def initialize(key,date)
    @key = key
    @date = date
  end

  def module_39(num)
    num % 39
  end

  def date_squared
    squared = @date**2
    squared_array = squared.to_s.split("").map(&:to_i)
    date_offset = squared_array[-4..-1]
  end

  def key_rotation
    key_array = @key.to_s.split("").map(&:to_i)
    a = key_array[0..1].join.to_i + date_squared[0]
    b = key_array[1..2].join.to_i + date_squared[1]
    c = key_array[2..3].join.to_i + date_squared[2]
    d = key_array[3..4].join.to_i + date_squared[3]
    rotation = [a,b,c,d]
  end
end

class Key
  def get_key
    key = []
    1.times do
      key << rand(1...9)
    end
    4.times do
      key << rand(0...9)
    end
    key.join.to_i
  end
end