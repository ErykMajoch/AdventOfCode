using Combinatorics

function day_nine()
  lines = readlines("input.txt")
  dict = Dict{Tuple{String,String}, Int}()
  unique_places = Set{String}()

  for line in lines
    words = split(line, " ")

    orig = words[1]
    dest = words[3]
    cost = parse(Int, words[5])

    dict[(orig, dest)] = cost
    dict[(dest, orig)] = cost

    push!(unique_places, orig)
    push!(unique_places, dest)
  end

  min_distance = Inf
  max_distance = 0

  all_perms = permutations(collect(unique_places))
  for perm in all_perms
    current_dist = 0
    for i in range(1, 7)
      x = (perm[i], perm[i + 1])
      current_dist += dict[x]
    end
    min_distance = min(min_distance, current_dist)
    max_distance = max(max_distance, current_dist)
  end

  return (min=min_distance, max=max_distance)

end

results = day_nine()

println("Part one: ", results.min)
println("Part two: ", results.max)
