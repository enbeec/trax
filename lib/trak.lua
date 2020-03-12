--- trak
-- heavily-ripped from dndrks' cheat codes 'pattern_time'

local trak = {}
trak.__index = trak

--- constructor
function trak.new(default_time,the_count)
  local i = {}
  setmetatable(i, trak)
  i.play = 0
  i.prev_time = 0
  i.event = {}
  i.count = 16 or the_count
  i.step = 1
  i.time_factor = 1
  i.loop = 1

  local time_mt = { __index = function(t,k) return t.default end }
  i.time = {}
  i.time.default = default_time or 0.25
  i.time = setmetatable(i.time,time_mt)

  i.metro = metro.init(function() i:next_event() end,1,1)

  local function trakker(_) 
    local val = i.event[i.step]
      if val == nil then
        print('nothing to do')
      else
        print('doing -> ' .. val)
        engine.noteOn(val,440,30,val)
      end
  end

  i.process = trakker

  -- i.process = function(_) print("event " .. i.step) end

  return i
end

--- start this trak
function trak:start()
  -- if self.count > 0 then
    --print("start trak ")
  self.process(self.event[1])
  self.play = 1
  self.step = 1
  self.metro.time = self.time[1] * self.time_factor
  self.metro:start()
  -- end
end

function trak:reset()
  self.step = 1
  self.metro.time = self.time[1] * self.time_factor
end

function trak:bang()
  self.process(self.event[self.step])
  if self.step == self.count then
    self.step = 1
  else
    self.step = self.step + 1
  end
end


--- process next event
function trak:next_event()
  if self.step == self.count and self.loop == 1 then 
    self.step = 1
    engine.noteOffAll()
  else self.step = self.step + 1 end
    --print("next step "..self.step)
    --event_exec(self.event[self.step])
    self.process(self.event[self.step])
    self.metro.time = self.time[self.step] * self.time_factor
    --print("next time "..self.metro.time)
  if self.step == self.count and self.loop == 0 then
    if self.play == 1 then
      self.play = 0
      self.metro:stop()
    end
  else
    self.metro:start()
  end
end

--- stop this trak
function trak:stop()
  if self.play == 1 then
    --print("stop trak ")
    self.play = 0
    self.metro:stop()
  else print("not playing") end
end

--- clear this trak
function trak:clear()
  self.metro:stop()
  self.rec = 0
  self.play = 0
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

