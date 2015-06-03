#There is a message that needs to be encrypted
#There is a primary 5 digit key to encrypt the message
# A rotation = first and second digits
# B rotation = second and third digits
# C rotation = third and fourth digits
# D rotation = fourth and fifth digits
#There is also a date offset factored into the encryption
#Offset key = Last four digits of the square of DDMMYY in numeric form
# A rotation = first digit
# B rotation = second digit
# C rotation = third digit
# D rotation = fourth digit
#Final key:
# A rotation = Primary(A) + Offset(A)
# B rotation = Primary(B) + Offset(B)
# C rotation = Primary(C) + Offset(C)
# D rotation = Primary(D) + Offset(D)
#Grab the first grouping of four elements of the message
#Encrypt the first element of the group with Final(A)
#Encrypt the second element of the group with Final(B)
#Encrypt the third element of the group with Final(C)
#Encrypt the fourth element of the group with Final(D)
#Repeat for all groupings of 4 in message until there is a new encrpyted message

require 'date'

class Encoded
  attr_reader :message

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

  def get_encrypted_values
    get_key_values.map do |group|
      group.each_with_index.map do |x,i|
        module_39(x + key_rotation[i])
      end
    end
  end

  def get_encrypted_keys
    get_encrypted_values.map do |group|
      group.map do |x|
        @map.key(x)
      end
    end
  end

  def get_encrypted_message
    get_encrypted_keys.join
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

