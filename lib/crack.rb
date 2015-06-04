
require_relative 'crack_decoded'

class Crack
  attr_reader :date

  def initialize(message = nil, output = nil, date)
    @message = message
    @output_file = output
    @date = date
  end

  def file_reader
    message_file = File.open(@message, "r")
    decoded_message = CrackDecoded.new(message_file.readline.split(""),@date).get_decrypted_message
    file_writer(decoded_message)
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
      decrypt = Crack.new(ARGV[0], ARGV[1], ARGV[2].to_i)
      decrypt.file_reader
      puts "Rewrote #{ARGV[1]} on the date #{decrypt.date}."
      end
    else
      decrypt = Crack.new(ARGV[0], ARGV[1], ARGV[2].to_i)
      decrypt.file_reader
      puts "Created #{ARGV[1]} on the date #{decrypt.date}."
    end
  end
end
