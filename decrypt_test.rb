require 'minitest/autorun'
require 'minitest/pride'
require_relative 'decrypt'

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

  def test_message_can_be_grouped
    skip
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = [["t","r","y", " "],["t", "o", " ", "e"],["n","c","r","y"],["p","t", " ","t"],["h","i","s","."]]
    assert_equal grouped, enigma.get_grouped_array
  end

  def test_date_gets_squared
    skip
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    assert_equal [0,2,2,5], enigma.date_squared
  end

  def test__key_rotation_is_set_with_map_and_date
    skip
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    assert_equal [31,12,11,97], enigma.key_rotation
  end

  def test_get_message_values
    skip
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = [[19, 17, 24, 36], [19, 14, 36, 4], [13, 2, 17, 24], [15, 19, 36, 19], [7, 8, 18, 37]]
    assert_equal grouped, enigma.get_key_values
  end

  def test_get_encrypted_values
    skip
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = [[11, 29, 35, 16], [11, 26, 8, 23], [5, 14, 28, 4], [7, 31, 8, 38], [38, 20, 29, 17]]
    assert_equal grouped, enigma.get_encrypted_values
  end

  def test_get_encrypted_keys
    skip
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = [["l", "3", "9", "q"], ["l", "0", "i", "x"], ["f", "o", "2", "e"], ["h", "5", "i", ","], [",", "u", "3", "r"]]
    assert_equal grouped, enigma.get_encrypted_keys
  end

  def test_get_decrypted_message
    skip
    enigma = Decoded.new("t39qt0ixno2ep5i,hu3r", 31092, 30615)
    grouped = "l39ql0ixfo2eh5i,,u3r"
    assert_equal grouped, enigma.get_encrypted_message
  end

  def test_file_reader_and_writer_works
    skip
    enigma = Decrypt.new("message1.txt", "encrypted1.txt")
    assert_equal "Try to encrypt this.", "message1.txt".readline

    encrypted = "l39ql0ixfo2eh5i,,u3r"
    enigma.file_reader
    assert_equal encrypted, "encrypted1.txt".readline
  end

  def test_the_decoder_works_for_a_hardcoded_message
    skip
    enigma = Decoded.new("l39ql0ixfo2eh5i,,u3r")
    assert_equal "try to encrypt this.", enigma.get_decrypted_message
  end

  def test_there_is_a_message_to_encrypt
    skip
    enigma = Encrypt.new("message.txt")
    assert_equal "try to encrypt this.", enigma.file_reader
  end
end
