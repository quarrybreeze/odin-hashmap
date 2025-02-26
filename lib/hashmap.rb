require_relative 'node'

class HashMap

  attr_accessor :buckets, :capacity
  
  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity) {[]}
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)
    hash_code = self.hash(key)
    hash = hash_code % @capacity #temporary
    data = [key,value]

    if @buckets[hash][0] == nil                     #if no head
      @buckets[hash][0] = Node.new(data, nil)
    elsif @buckets[hash][0].value.first == key
      @buckets[hash][0].value = data
    else
      @buckets[hash][0].next_node = Node.new(data,nil)
      # p "Collision detected #{key} and #{value}"
    end

  end

  def get(key)
    hash_code = self.hash(key)
    hash = hash_code % @capacity

    current = @buckets[hash][0]
    
    if self.has?(key) == false
      return nil
    else
      while current.value.first != key
        current = current.next_node
      end
      current.value.last
    end
    # if @buckets[hash][0] == nil
    #   return nil
    # elsif @buckets[hash][0].value.first == key
    #   return @buckets[hash][0].value.last
    # else
    #   while @buckets[hash][0].next_node != nil
    #     @buckets[hash][0] = @buckets[hash][0].next_node
    #     if @buckets[hash][0].value.first == key
    #       return @buckets[hash][0].value.last
    #     end
    #   end
    # end
  end

  # def node_length(key)
  #   hash_code = self.hash(key)
  #   hash = hash_code % @capacity
  #   length = 1

  #   while @buckets[hash][0].next_node != nil
  #     length += 1
  #     @buckets[hash][0] = @buckets[hash][0].next_node
  #   end
  #   length
  # end

  def has?(key)
    hash_code = self.hash(key)
    hash = hash_code % @capacity
    found = false

    current = @buckets[hash][0]

    if current == nil
      found = false
    elsif current.value.first == key
      found = true
    else
      while current.next_node != nil
        current = current.next_node
        if current.value.first == key
          found = true
        end
      end
    end
    return found
  end

  def remove(key)
    hash_code = self.hash(key)
    hash = hash_code % @capacity

    if self.has?(key) == false
      return nil
    else
      while @buckets[hash][0].value.first != key
        @buckets[hash][0] = @buckets[hash][0].next_node
      end
      value = @buckets[hash][0].value.last
      @buckets[hash][0] = @buckets[hash][0].next_node
      return value
    end
  end

  def length
    length = 0
    for i in 0..(@capacity-1)
      if @buckets[i][0] != nil
        length += 1
        current = @buckets[i][0]
        while current.next_node != nil
          current = current.next_node
          length += 1
        end
      end
    end
    return length
  end

  def clear

  end

  def keys
    
  end

  def values

  end

end

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
p test.length

# p test.has?('grape')
# p test.get('grape')
# p test.has?('hat')
# p test.get('hat')
# p test.remove('grape')
# p test.get('grape')
# p test.has?('grape')
# p test.has?('hat')
# p test.get('hat')
# p test.remove('hat')
# p test.has?('hat')
# p test.get('grape')
# p test.get('hat')

# p test.node_length('hat')


# p test.hash('apple') #10
# p test.hash('banana') #5
# p test.hash('carrot') #3
# p test.hash('dog') #12
# p test.hash('elephant') #1
# p test.hash('frog') #4
# p test.hash('grape') #11
# p test.hash('hat') #11
# p test.hash('ice cream') #13
# p test.hash('jacket') #14
# p test.hash('kite') #15
# p test.hash('lion') #12