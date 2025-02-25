require_relative 'node'

class HashMap
  
  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @hash = {}
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)
    hash_code = self.hash(key)

    @hash[hash_code] = Node.new(value)

    #adding linked list to collissions?
    # if @hash[hash_code] == nil
    #   
    # else
    #   while @hash[hash_code].next_node != nil
    #     @hash[hash_code] = @hash[hash_code].next_node
    #   end
    #   @hash[hash_code].next_node = Node.new(value)
    # end
  end

  def get(key)
    hash_code = self.hash(key)
    @hash[hash_code].value
  end

  def has?(key)
    hash_code = self.hash(key)
    if @hash[hash_code] == nil
      return false
    else
      return true
    end
  end

  def remove(key)
    hash_code = self.hash(key)
    if self.has?(key)
      value = @hash[hash_code].value
      @hash.delete(hash_code)
      return value
    else
      return nil
    end
  end

  def length
    @hash.length
  end

  def clear
    @hash.clear
  end

  def keys
    
  end

  def values

  end

end

test = HashMap.new

test.set('apple', 'red')
test.set('apple', 'blue')
p test.get('apple')
# p test.has?('apple')
# p test.has?('bear')
# p test.remove('apple')
# p test.remove('bear')
p test.length
# p test.@hash