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
  end

  def get(key)
    hash_code = self.hash(key)

    @hash[hash_code]
  end

end

test = HashMap.new

test.set('apple', 'red')
p test.get('apple')