def generate_pass(length, digits, caps, syms)
  rest = length - digits - caps - syms
  raise "ERROR: More specials than length!" if rest < 0

  symbols = "!#%&".chars
  pass = ''

  digits.times { pass << rand(10).to_s }
  syms.times   { pass << symbols.sample }
  caps.times   { pass << (65 + rand(26)) }
  rest.times   { pass << (97 + rand(26)) }

  pass.chars.shuffle.join
end

case ARGV[0]
when '-f'
  o = 2
  seed = 0
  ARGV[1].split(',').each do |n|
    File.open(n, 'r') do |f|
      f.each_byte { |b| seed += b }
    end
  end
when '-s'
  o = 2
  seed = ARGV[1].to_i
else
  o = 0
  seed = Time.now.to_i
end

puts "Random seed = #{seed}"
srand(seed)

length = (ARGV[o+0] ? ARGV[o+0].to_i : 16)
digits = (ARGV[o+1] ? ARGV[o+1].to_i : length / 8)
caps   = (ARGV[o+2] ? ARGV[o+2].to_i : length / 8)
syms   = (ARGV[o+3] ? ARGV[o+3].to_i : length / 8)

10.times { puts generate_pass(length, digits, caps, syms) }
