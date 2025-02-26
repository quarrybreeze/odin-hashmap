require_relative 'node'

class HashMap

  attr_accessor :buckets, :capacity
  
  def initialize(load_factor = 0.75, capacity = 16)
    @load_factor = load_factor
    @capacity = capacity
    @buckets = Array.new(capacity) {[]}
  end

  def hash(key) #provided by project
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)

    hash_code = self.hash(key)
    hash = hash_code % @capacity
    data = [key,value]

    if @buckets[hash][0] == nil                     #if no head
      @buckets[hash][0] = Node.new(data, nil)       #make a head
    else
      while @buckets[hash][0]                       #otherwise.
        if @buckets[hash][0].value.first == key     #if the key matches
          @buckets[hash][0].value = data            #update the value
          return
        elsif @buckets[hash][0].next_node == nil        #if no keys matched AND its the last node
          @buckets[hash][0].next_node = Node.new(data)  #create a new node
          return
        else
          @buckets[hash][0] = @buckets[hash][0].next_node #if no keys matched but there are still nodes to check, loop to next node
        end
      end
    end
    
    if self.length > (@load_factor.to_f*@capacity.to_i)
      self.resize
    end

  end

  def resize
    @capacity *= 2
    entries_array = self.entries 
    self.clear           
    entries_array.each do |entry|     #rehash to minimize collisions in new bigger capacity
      self.set(entry[0], entry[1])
    end
  end
  

  def get(key)
    hash_code = self.hash(key)
    hash = hash_code % @capacity

    current = @buckets[hash][0]
    
    if self.has?(key) == false   #if key exists, jump to next node and find key and then return the value
      return nil
    else
      while current.value.first != key
        current = current.next_node
      end
      current.value.last
    end

  end


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
    @buckets = Array.new(@capacity) {[]}
  end
  

  def keys
    keys_array = []

    for i in 0..(@capacity-1)
      if @buckets[i] != nil && @buckets[i][0] != nil #if a key exists
        keys_array << @buckets[i][0].value.first
        current = @buckets[i][0]
        while current.next_node != nil  #check if there are linked nodes
          current = current.next_node
          keys_array << current.value.first
        end
      end
    end
    return keys_array
  end

  def values
    values_array = []

    for i in 0..(@capacity-1)
      if @buckets[i] != nil && @buckets[i][0] != nil #if a value exists
        values_array << @buckets[i][0].value.last
        current = @buckets[i][0]
        while current.next_node != nil #check if there are linked nodes
          current = current.next_node
          values_array << current.value.last
        end
      end
    end
    return values_array
  end

  def entries
    entries_array = []
    individual_entry = []

    for i in 0..(@capacity-1)
      if @buckets[i] != nil && @buckets[i][0] != nil   #if a value exists
        individual_entry << @buckets[i][0].value.first
        individual_entry << @buckets[i][0].value.last
        entries_array << individual_entry
        individual_entry = []
        current = @buckets[i][0]
        while current.next_node != nil                  #check if there are linked nodes
          current = current.next_node
          individual_entry << current.value.first
          individual_entry << current.value.last
          entries_array << individual_entry
          individual_entry = []
        end
      end
    end
    return entries_array
  end

end