--- trak
-- based on dndrks cheat_codes pattern module

local trak = {}
trak.__index = trak

--- constructor
function trak.new()
  local i = {}
  setmetatable(i, trak)
  i.rec = 0
  i.play = 0
  i.prev_time = 0
  i.event = {}
  i.time = {}
  i.count = 0
  i.step = 0
  i.time_factor = 1
  i.loop = 1

  i.metro = metro.init(function() i:next_event() end,1,1)

  i.process = function(_) print("event") end

  return i
end

--- clear this trak
function trak:clear()
  self.metro:stop()
  self.rec = 0
  self.play = 0
  self.prev_time = 0
  self.event = {}
  self.time = {}
  self.count = 0
  self.step = 0
  self.time_factor = 1
end

--- adjust the time factor of this trak.
-- @tparam number f time factor
function trak:set_time_factor(f)
  self.time_factor = f or 1
end

return trak

