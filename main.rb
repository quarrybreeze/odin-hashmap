require_relative 'lib/hashmap'

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

p "added 12 items"

p test.length

p test.capacity

test.set('elephant', 'turqoise')
test.set('frog', 'lime')
test.set('grape', 'butterscotch')

p test.length

p test.capacity

test.set('moon', 'silver')

p test.length
p test.capacity

test.set('jacket', 'rainbow')
test.set('kite', 'sky blue')
test.set('lion', 'slate')

p test.length

p test.get('elephant')
p test.has?('elephant')
p test.keys
p test.values
p test.entries
test.clear
p test.entries

p test.capacity