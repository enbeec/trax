local counts = {
  four_four={ 
    quarter={
      [1]="one",[5]="two",[9]="three",[13]="four"
    },
    eigth={
      [1]="one",[5]="two",[9]="three",[13]="four", 
      [3]="and",[7]="and",[11]="and",[15]="and"
    },
    sixteenth={
      [1]="1",[5]="2",[9]="3",[13]="4", 
      [2]="e",[6]="e",[10]="e",[14]="e",
      [3]="&",[7]="&",[11]="&",[15]="&",
      [4]="a",[8]="a",[12]="a",[16]="a"
    },
    takadimi={
      "ta", "ka", "di", "mi",
      "ta", "ka", "di", "mi",
      "ta", "ka", "di", "mi",
      "ta", "ka", "di", "mi"
    }}
}

local counts_mt = { __index = function (t, k) return "---" end }

local hex_mt = { __index = function (t,k) return string.format('%02x', k-1) end }

local function counts_metatables()
  -- TODO: apply metatable to each counts.x.y table for x,y
  counts.four_four.quarter = setmetatable(
    counts.four_four.quarter, counts_mt)
  counts.four_four.eigth = setmetatable(
    counts.four_four.eigth, counts_mt)
  counts.four_four.sixteenth = setmetatable(
    counts.four_four.sixteenth, counts_mt)
  counts.hex = setmetatable(
    counts.hex, hex_mt)
end

function counts.newHex()
  local t = {}
  local mt = { __index = function (t,k) return string.format('%02x', k-1) end }
  t = setmetatable(t, mt)
  return t
end

function counts.newBlank(num)
  local s = ""
  for i=1,num do
    s = s .. "-"
  end
  local t = {}
  local mt = { __index = function (t, k) return s end }
  t = setmetatable(t, mt)
  return t
end

return counts