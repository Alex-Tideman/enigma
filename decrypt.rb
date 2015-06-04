# require_relative 'decoded'
#
# class Decrypt
#   attr_reader :message, :key, :date
#
#   def initialize(message = nil, output = nil, key, date)
#     @message = message
#     @output_file = output
#     @key = key
#     @date = date
#   end
#
#   def file_reader
#     message_file = File.open(@message, "r")
#     decoded = Decoded.new(message_file.readlines[0], @key, @date).get_decrypted_message
#     file_writer(decoded)
#   end
#
#   def file_writer(cipher)
#     decrytped_file = File.open(@output_file, "w")
#     decrytped_file.write(cipher)
#   end
# end
#
# if __FILE__ == $0
#   decrypt = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3].to_i)
#   decrypt.file_reader
#   puts "Created #{ARGV[1]} with the key #{decrypt.key} and date #{decrypt.date}."
# end

require_relative 'decoded'

class Decrypt
  attr_reader :message, :key, :date

  def initialize(message = nil, output = nil, key, date)
    @message = message
    @output_file = output
    @key = key
    @date = date
  end

  def file_reader
    message_file = File.open(@message, "r")
    decoded = Decoded.new(message_file.readlines[0], @key, @date).get_decrypted_message
    file_writer(decoded)
  end

  def file_writer(cipher)
    decrytped_file = File.open(@output_file, "w")
    decrytped_file.write(cipher)
  end
end

if __FILE__ == $0
  decrypt = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3].to_i)
  decrypt.file_reader
  puts "Created #{ARGV[1]} with the key #{decrypt.key} and date #{decrypt.date}."
end
