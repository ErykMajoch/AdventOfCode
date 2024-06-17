
function parse_file()
  local ingredients = {}
  for line in io.lines("input.txt") do
    local words = split(line, ", ")
    local current = {}
    current.cap = tonumber(words[3])
    current.dur = tonumber(words[5])
    current.flv = tonumber(words[7])
    current.tex = tonumber(words[9])
    current.cal = tonumber(words[11])
    table.insert(ingredients, current)
  end
  return ingredients
end

function split(str, delims)
  local t = {}
  for s in string.gmatch(str, "([^"..delims.."]+)") do
    table.insert(t, s)
  end
  return t
end

function find_cookies(p2)
  local ings = parse_file()
  local max_val = 0
  for a = 0, 100 do
    for b = 0, 100 - a do
      for c = 0, 100 - a - b do
        local d = 100 - a - b - c

        if d >= 0 then
          local cap = (ings[1].cap * a) + (ings[2].cap * b) + (ings[3].cap * c) + (ings[4].cap * d)
          local dur = (ings[1].dur * a) + (ings[2].dur * b) + (ings[3].dur * c) + (ings[4].dur * d)
          local flv = (ings[1].flv * a) + (ings[2].flv * b) + (ings[3].flv * c) + (ings[4].flv * d)
          local tex = (ings[1].tex * a) + (ings[2].tex * b) + (ings[3].tex * c) + (ings[4].tex * d)
          local cal = (ings[1].cal * a) + (ings[2].cal * b) + (ings[3].cal * c) + (ings[4].cal * d)
          local current = cap * dur * flv * tex

          if p2 then
           if cal == 500 then
            if (cap <= 0) or (dur <= 0) or (flv <= 0) or (tex <= 0) then
              current = 0
            end

            max_val = math.max(max_val, current)

            end
          else
            if (cap <= 0) or (dur <= 0) or (flv <= 0) or (tex <= 0) then
              current = 0
            end

            max_val = math.max(max_val, current)
          end
        end
      end
    end
  end
  return max_val
end

print(string.format("Part one: %d", find_cookies(false)))
print(string.format("Part two: %d", find_cookies(true)))

