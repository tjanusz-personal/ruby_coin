
def do_calc(number)
  case 0
    when number % 15
      "FizzBuzz"
    when number % 3
      "Fizz"
    when number % 5
      "Buzz"
  else
    number.to_s
  end
end

def do_calc2(number)
  return "FizzBuzz" if number % 15 == 0
  return "Fizz" if number % 3 == 0
  return "Buzz" if number % 5 == 0
  number.to_s
end

def do_sort_test(the_hash)
  key_array = the_hash.keys.map(&:to_s)
  key_array.sort!{ |x,y| x.length <=> y.length}
  key_array
end

# the_hash = { abc: "hello", 'another_key' => 123, 4567 => 'third'}
# puts do_sort_test(the_hash)
# ['abc', "4567", "another_key"]
# (0..100).each {|number| puts do_calc2(number)}
