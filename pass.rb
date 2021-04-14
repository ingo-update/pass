length = (ARGV[0] ? ARGV[0].to_i : 16)
digits = (ARGV[1] ? ARGV[1].to_i : 2)
caps =   (ARGV[2] ? ARGV[2].to_i : 2)
syms =   (ARGV[2] ? ARGV[3].to_i : 2)

if digits + caps + syms > length
  raise "ERROR: More specials than length!"
end

$prng = Random.new(Time.now.to_i)
$used = []

def new_index(max)
  i = $prng.rand(max)
  while $used.include?(i)
    i = $prng.rand(max)
  end
  $used << i
  i
end

def create_pass(length, digits = 0, caps = 0, syms = 0)

  symbols = "!#%&".chars.to_a

  $used = []
  pass = ''

  length.times do
    pass << (97 + $prng.rand(26))
  end

  caps.times do
    i = new_index(length)
    pass[i] = pass[i].upcase
  end

  digits.times do 
    i = new_index(length)
    pass[i] = $prng.rand(10).to_s
  end

  syms.times do
    i = new_index(length)
    pass[i] = symbols[$prng.rand(symbols.length-1)]
  end

  pass

end

10.times { puts create_pass(length, digits, caps, syms) }
