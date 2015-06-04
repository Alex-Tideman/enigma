require 'date'
require 'pry'
require_relative 'encoded'
require_relative 'key_creator'


class Encrypt
  attr_reader :key, :date

  def initialize(message = nil, output = nil)
    @message = message
    @output_file = output
    @key = Key.new.get_key
    # @key = 31092
    @date = Date.today.strftime("%d%m%y").split("-").join.to_i
  end

  def file_reader
    message_file = File.open(@message, "r")
    ciphertext = Encoded.new(message_file.readline.split(""),@key,@date).get_encrypted_message
    file_writer(ciphertext)
    message_file.close
  end

  def file_writer(cipher)
    encrytped_message = File.open(@output_file, "w")
    encrytped_message.write(cipher)
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
          encrypt = Encrypt.new(ARGV[0], ARGV[1])
          encrypt.file_reader
          puts "Rewrote #{ARGV[1]} with the key #{encrypt.key} and the date #{encrypt.date}."
        end
    else
      encrypt = Encrypt.new(ARGV[0], ARGV[1])
      encrypt.file_reader
      puts "Created #{ARGV[1]} with the key #{encrypt.key} and the date #{encrypt.date}."
    end
  end
end


