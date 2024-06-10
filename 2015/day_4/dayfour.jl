using MD5

input = "bgvyzdsv"

function start_with(zeros)
  counter = 0
  while true
    hash = bytes2hex(md5(string(input, counter)))
    if chop(hash, head=0, tail=length(hash)-length(zeros)) == zeros
      break
    else
      counter += 1
    end
  end
  return counter
end

println("Part one: ", start_with("00000"))
println("Part two: ", start_with("000000"))
