require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)

  (0...(string.length-1)).each do |i|
    (i+1...string.length).each do |j|
      word = string[i..j]
      return true if word == word.reverse
    end
  end
  false
end
