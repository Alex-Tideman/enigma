require 'date'
require_relative 'crack_decoded'

class Crack
  attr_reader :date

  def initialize(message = nil, output = nil, date)
    @message = message
    @output_file = output
    @date = date
  end

  def file_reader
    message_file = File.open(@message, "r").readline
    decoded_message = CrackDecoded.new(message_file.split(""),@date).get_decrypted_message
    file_writer(decoded_message)
  end

  def file_writer(cipher)
    decrytped_file = File.open(@output_file, "w")
    decrytped_file.write(cipher)
  end

  def get_key
    message_file = File.open(@message, "r").readline
    key = CrackDecoded.new(message_file.split(""),@date).find_key
  end
end

if __FILE__ == $0
  decrypt = Crack.new(ARGV[0], ARGV[1], ARGV[2].to_i)
  decrypt.file_reader
  puts "Created #{ARGV[1]} with the cracked key #{decrypt.get_key} and the date #{decrypt.date}"
end