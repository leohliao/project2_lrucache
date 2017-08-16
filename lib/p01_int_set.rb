require "byebug"

class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    return false if @store[num]
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    return nil unless include?(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @max - 1)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num] = num
  end

  def remove(num)
    if include?(num)
      @store[num] = []
    end
  end

  def include?(num)
    @store[num] == num
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    retun false if include?(num)
    self[num] << num
    @count += 1
    resize! if check_counts

    num
  end

  def remove(num)
    self[num].delete(num) if include?(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
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
    store_holder.flatten.each do |n|
      insert(n)
    end
  end
end
