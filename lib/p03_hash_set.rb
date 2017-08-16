require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    self[key.hash] << key
    @count += 1
    resize! if check_counts
  end

  def include?(key)
    self[key.hash].include?(key)
  end

  def remove(key)
    self[key.hash].delete(key) if include?(key)
    @count -= 1
  end

  private

  def check_counts
    @count > num_buckets
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_holder = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    store_holder.flatten.each {|el| insert(el) }
  end
end
