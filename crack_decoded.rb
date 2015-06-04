require_relative 'key_creator'

class CrackDecoded

  def initialize(message,date)
    @message = message
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

  #Last_array.size == 4
  #Final message: last.array = [nd..] -> [13,4,38,38]
  #Encrypted message: last.array = [w,x,y,z]
  # (get_key_values[-1][0] - a - date_squared[0]) % 39 = 13
  # (get_key_values[-1][1] - b - date_squared[1]) % 39 = 3
  # (get_key_values[-1][2] - c - date_squared[2]) % 39 = 37
  # (get_key_values[-1][3] - d - date_squared[3]) % 39 = 37

  #Last_array.size == 3
  #Final message: second_last_array = [..en] -> [38,38,4,13]
  #Encrypted message: second_last_array = [w,x,y,z]
  # (get_key_values[-2][0] - a - date_squared[0]) % 39 = 37
  # (get_key_values[-2][1] - b - date_squared[1]) % 39 = 37
  # (get_key_values[-2][2] - c - date_squared[2]) % 39 = 4
  # (get_key_values[-2][3] - d - date_squared[3]) % 39 = 13

  #Last_array.size == 2
  #Final message: second_last_array = [.end] -> [38,4,13,3]
  #Encrypted message: second_last_array = [w,x,y,z]
  # (get_key_values[-2][0] - a - date_squared[0]) % 39 = 37
  # (get_key_values[-2][1] - b - date_squared[1]) % 39 = 4
  # (get_key_values[-2][2] - c - date_squared[2]) % 39 = 13
  # (get_key_values[-2][3] - d - date_squared[3]) % 39 = 3

  #Last_array.size == 1
  #Final message: second_last_array = [end.] -> [4,13,3,38]
  #Encrypted message: second_last_array = [w,x,y,z]
  # (get_key_values[-2][0] - a - date_squared[0]) % 39 = 4
  # (get_key_values[-2][1] - b - date_squared[1]) % 39 = 13
  # (get_key_values[-2][2] - c - date_squared[2]) % 39 = 3
  # (get_key_values[-2][3] - d - date_squared[3]) % 39 = 37

  def key_rotation
      if get_key_values[-1].size == 4
        a = get_key_values[-1][0] - 13
        b = get_key_values[-1][1] - 3
        c = get_key_values[-1][2] - 37
        d = get_key_values[-1][3] - 37
      elsif get_key_values[-1].size == 3
        a = get_key_values[-2][0] - 37
        b = get_key_values[-2][1] - 37
        c = get_key_values[-2][2] - 4
        d = get_key_values[-2][3] - 13
      elsif get_key_values[-1].size == 2
        a = get_key_values[-2][0] - 37
        b = get_key_values[-2][1] - 4
        c = get_key_values[-2][2] - 13
        d = get_key_values[-2][3] - 3
      elsif get_key_values[-1].size == 1
        a = get_key_values[-2][0] - 4
        b = get_key_values[-2][1] - 13
        c = get_key_values[-2][2] - 3
        d = get_key_values[-2][3] - 37
      end
    rotation = [a,b,c,d]
  end

  def find_key
      key = [(key_rotation[0] - @key_creator.date_squared[0])%39,(key_rotation[1] - @key_creator.date_squared[1])%39,
             (key_rotation[2] - @key_creator.date_squared[2])%39,(key_rotation[3] - @key_creator.date_squared[3])%39].join.to_i
  end

  def get_grouped_array
    split_message = @message
    groups = []
    (0...split_message.length).each do |char|
      groups.push(split_message[char].downcase)
    end
    groups.each_slice(4).to_a
  end

  def get_key_values
    get_grouped_array.map do |group|
      group.collect do |x|
        @map[x]
      end
    end
  end

  def get_decrypted_values
    get_key_values.map do |group|
      group.each_with_index.map do |x,i|
        @key_creator.module_39(x - key_rotation[i])
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