class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.reduce(0) do |hash, (el, idx)|
     hash ^ (el.hash + idx.hash)
    end
  end
end

class String
  def hash
    self.chars.map{ |ch| ch.ord }.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort_by {|el| el }.hash
  end
end
