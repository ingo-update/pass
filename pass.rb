@rnd = Random.new(Time.now.to_i)

def generate_pass(length, digits, caps, syms)

  rest = length - digits - caps - syms
  raise "ERROR: More specials than length!" if rest < 0

  symbols = "!#%&".chars.to_a
  pass = ''

  digits.times { pass << @rnd.rand(10).to_s }
  syms.times   { pass << symbols.sample }
  caps.times   { pass << (65 + @rnd.rand(26)) }
  rest.times   { pass << (97 + @rnd.rand(26)) }

  pass.chars.shuffle.join
end

length = (ARGV[0] ? ARGV[0].to_i : 16)
digits = (ARGV[1] ? ARGV[1].to_i : length / 8)
caps =   (ARGV[2] ? ARGV[2].to_i : length / 8)
syms =   (ARGV[3] ? ARGV[3].to_i : length / 8)

10.times { puts generate_pass(length, digits, caps, syms) }
