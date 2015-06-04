require 'minitest/autorun'
require 'minitest/pride'
require_relative 'encrypt'
require_relative 'encoded'

class TestEncrypt < Minitest::Test

  #FOR TESTS I USED KEY 31092
  def test_there_is_an_enigma_machine
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    assert enigma
  end

  def test_there_is_a_message_to_encrypt
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    assert_equal "Try to encrypt this.", enigma.message
  end

  def test_message_can_be_grouped
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    grouped = [["t","r","y", " "],["t", "o", " ", "e"],["n","c","r","y"],["p","t", " ","t"],["h","i","s","."]]
    assert_equal grouped, enigma.get_grouped_array
  end

  def test_date_gets_squared
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    assert_equal [8,2,2,5], enigma.date_squared
  end

  def test__key_rotation_is_set_with_map_and_date
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    assert_equal [39,12,11,97], enigma.key_rotation
  end

  def test_get_message_values
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    grouped = [[19, 17, 24, 36], [19, 14, 36, 4], [13, 2, 17, 24], [15, 19, 36, 19], [7, 8, 18, 37]]
    assert_equal grouped, enigma.get_key_values
  end

  def test_get_encrypted_values
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    grouped = [[19, 29, 35, 16], [19, 26, 8, 23], [13, 14, 28, 4], [15, 31, 8, 38], [7, 20, 29, 17]]
    assert_equal grouped, enigma.get_encrypted_values
  end

  def test_get_encrypted_keys
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    grouped = [["t", "3", "9", "q"], ["t", "0", "i", "x"], ["n", "o", "2", "e"], ["p", "5", "i", ","], ["h", "u", "3", "r"]]
    assert_equal grouped, enigma.get_encrypted_keys
  end

  def test_get_encrypted_message
    enigma = Encoded.new("Try to encrypt this.", 31092, 30615)
    grouped = "t39qt0ixno2ep5i,hu3r"
    assert_equal grouped, enigma.get_encrypted_message
  end

  def test_file_reader_and_writer_works
    skip
    enigma = Encrypt.new("message1.txt", "encrypted1.txt")
    assert_equal "Try to encrypt this.", "message1.txt".readline

    encrypted = "l39ql0ixfo2eh5i,,u3r"
    enigma.file_reader
    assert_equal encrypted, "encrypted1.txt".readline
  end

end