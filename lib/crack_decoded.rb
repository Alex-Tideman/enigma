require_relative 'key_creator'
require_relative 'encoded'

class CrackDecoded

  def initialize(message,date)
    @message = message
    @date = date
    @map = Encoded.new(nil,nil,nil).map
    @key_creator = KeyCreator.new(@key,@date)
  end

  def key_rotation
      if get_decrypt_key_values[-1].size == 4
        a = get_decrypt_key_values[-1][0] - 13
        b = get_decrypt_key_values[-1][1] - 3
        c = get_decrypt_key_values[-1][2] - 37
        d = get_decrypt_key_values[-1][3] - 37
      elsif get_decrypt_key_values[-1].size == 3
        a = get_decrypt_key_values[-2][0] - 37
        b = get_decrypt_key_values[-2][1] - 37
        c = get_decrypt_key_values[-2][2] - 4
        d = get_decrypt_key_values[-2][3] - 13
      elsif get_decrypt_key_values[-1].size == 2
        a = get_decrypt_key_values[-2][0] - 37
        b = get_decrypt_key_values[-2][1] - 4
        c = get_decrypt_key_values[-2][2] - 13
        d = get_decrypt_key_values[-2][3] - 3
      elsif get_decrypt_key_values[-1].size == 1
        a = get_decrypt_key_values[-2][0] - 4
        b = get_decrypt_key_values[-2][1] - 13
        c = get_decrypt_key_values[-2][2] - 3
        d = get_decrypt_key_values[-2][3] - 37
      end
    rotation = [a,b,c,d]
  end

  def get_decrypt_key_values
    Encoded.new(@message,@key,@date).get_key_values
  end

  def get_decrypted_values
    get_decrypt_key_values.map do |group|
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