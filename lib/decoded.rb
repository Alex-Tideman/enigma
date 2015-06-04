require_relative 'encoded'

class Decoded
  attr_reader :message,:key,:date

  def initialize(message,key,date)
    @message = message
    @key = key
    @date = date
    @map = Encoded.new(nil,nil,nil).map
    @key_creator = KeyCreator.new(@key,@date)
  end

  def get_encrypted_key_values
      Encoded.new(@message,@key,@date).get_key_values
  end

  def get_decrypted_key_values
    get_encrypted_key_values.map do |group|
      group.each_with_index.map do |x,i|
        @key_creator.module_39(x - @key_creator.key_rotation[i])
      end
    end
  end

  def get_decrypted_keys
    get_decrypted_key_values.map do |group|
      group.map do |x|
        @map.key(x)
      end
    end
  end

  def get_decrypted_message
    get_decrypted_keys.join
  end

end