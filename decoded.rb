require_relative 'encoded'

class Decoded
  attr_reader :message,:key,:date

  def initialize(message,key,date)
    @message = message
    @key = key
    @date = date
    @map = {
        'a' => 0,
        'b' => 1,
        'c' => 2,
        'd' => 3,
        'e' => 4,
        'f' => 5,
        'g' => 6,
        'h' => 7,
        'i' => 8,
        'j' => 9,
        'k' => 10,
        'l' => 11,
        'm' => 12,
        'n' => 13,
        'o' => 14,
        'p' => 15,
        'q' => 16,
        'r' => 17,
        's' => 18,
        't' => 19,
        'u' => 20,
        'v' => 21,
        'w' => 22,
        'x' => 23,
        'y' => 24,
        'z' => 25,
        '0' => 26,
        '1' => 27,
        '2' => 28,
        '3' => 29,
        '4' => 30,
        '5' => 31,
        '6' => 32,
        '7' => 33,
        '8' => 34,
        '9' => 35,
        ' ' => 36,
        '.' => 37,
        ',' => 38 }
    @key_creator = KeyCreator.new(@key,@date)
  end

  def get_decrypt_key_values
      Encoded.new(@message,@key,@date).get_key_values
  end

  def get_decrypted_values
    get_decrypt_key_values.map do |group|
      group.each_with_index.map do |x,i|
        @key_creator.module_39(x - @key_creator.key_rotation[i])
      end
    end
  end

  def get_decrypted_keys
    get_decrypted_values.map do |group|
      group.map do |x|
        @map.key(x)
      end
    end
  end

  def get_decrypted_message
    get_decrypted_keys.join
  end

end