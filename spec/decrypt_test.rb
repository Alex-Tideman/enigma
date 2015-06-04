require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/decrypt'
require_relative '../lib/encoded'

class TestDecrypt < Minitest::Test
  #FOR TESTS I USED KEY 31092
  def test_there_is_an_enigma_machine
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    assert enigma
  end

  def test_there_is_a_message_to_decrypt
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    assert_equal "t39qt0ixno2ep5i,hu3r", enigma.message
  end

  def test_get_encrypted_key_values
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = [[19, 29, 35, 16], [19, 26, 8, 23], [13, 14, 28, 4], [15, 31, 8, 38], [7, 20, 29, 17]]
    assert_equal grouped, enigma.get_encrypted_key_values
  end

  def test_get_decrypted_key_values
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = [[19, 17, 24, 36], [19, 14, 36, 4], [13, 2, 17, 24], [15, 19, 36, 19], [7, 8, 18, 37]]
    assert_equal grouped, enigma.get_decrypted_key_values
  end

  def test_get_decrypted_keys
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = [["t", "r", "y", " "], ["t", "o", " ", "e"], ["n", "c", "r", "y"], ["p", "t", " ", "t"], ["h", "i", "s", "."]]
    assert_equal grouped, enigma.get_decrypted_keys
  end

  def test_get_decrypted_message
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = "try to encrypt this."
    assert_equal grouped, enigma.get_decrypted_message
  end

  def test_file_reader_and_writer_works
    skip
    enigma = Decrypt.new(ARGV[0], ARGV[1], 31092, 30615)
    encrypted = "l39ql0ixfo2eh5i,,u3r"
    assert_equal encrypted, ARGV[0].readline

    decrypted = "try to encrypt this."
    enigma.file_reader
    assert_equal decrypted, ARGV[1].readline
  end
end