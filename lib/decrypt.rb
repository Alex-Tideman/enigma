
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
    decoded = Decoded.new(message_file.readline, @key, @date).get_decrypted_message
    file_writer(decoded)
    message_file.close
  end

  def file_writer(cipher)
    decrytped_file = File.open(@output_file, "w")
    decrytped_file.write(cipher)
  end
end

class Runner
  if __FILE__ == $0
    file_exists = File.exist?(ARGV[1])
    if file_exists
      puts "Are you sure you want to overwrite your file?"
      answer = $stdin.gets.chomp
      if answer == 'n'
        abort("You exited.")
      else answer == 'y'
      decrypt = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3].to_i)
      decrypt.file_reader
      puts "Rewrote #{ARGV[1]} with the key #{decrypt.key} and the date #{decrypt.date}."
      end
    else
      decrypt = Decrypt.new(ARGV[0], ARGV[1], ARGV[2], ARGV[3].to_i)
      decrypt.file_reader
      puts "Created #{ARGV[1]} with the key #{decrypt.key} and the date #{decrypt.date}."
    end
  end
end

