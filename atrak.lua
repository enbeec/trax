--- trak

engine.name = 'Timber'
local timb = include("timber/lib/timber_engine")
local MusicUtil = require 'musicutil'

trak = include("trax/lib/trak")

t = {}

function init()
  t = trak.new()
  
    
    timb.add_params()
    for i = 0,3 do
        params:add_separator()
        timb.add_sample_params(i)
    end
  
    timb.load_sample(0 ,_path.audio .. "common/808/808-BD.wav")
    timb.load_sample(1 ,_path.audio .. "common/808/808-SD.wav")
    timb.load_sample(2 ,_path.audio .. "common/808/808-CH.wav")
    timb.load_sample(3 ,_path.audio .. "common/808/808-OH.wav")
    
    refreshmaker()
end

function noloop()
  params:set("play_mode_" .. 0, 4) -- 4 = '1-Shot'
  params:set("play_mode_" .. 1, 4) -- 4 = '1-Shot'
  params:set("play_mode_" .. 2, 4) -- 4 = '1-Shot'
  params:set("play_mode_" .. 3, 4) -- 4 = '1-Shot'
end

function loadtest(z)
  local junk = {0,1,2,3}
  for i=1,#junk do
    z.event[i] = junk[i] 
  end
end

local cursor = {
  scroll = 0,
  x = 1, y = 1,
  level = 6
}

function refreshmaker()
  re=metro.init()
  re=metro.init()
	re.time = 1.0/15
	re.event = function()
	  redraw()
	end
  screen.aa(1)
  re:start()
end

local vui = include("lib/vui")
local c = include("lib/counts")

local col_start = 16

function redraw()
  screen.clear()
  for i=1,16 do
    -- COL 7 -- RULER 2
    -- vui.screen_ruler()
    -- vui.move(vui.column_positions[7],vui.row_offset*(i-cursor.scroll)) 
    -- screen.text(c.four_four.sixteenth[i])

    -- draw step ruler 
    vui.screen_ruler()
    vui.move(0,vui.row_offset*(i-cursor.scroll)) 
    screen.text(string.format("%02X",i-1))
    -- draw '>' for current step
    if i == t.step then
      screen.move(11,vui.row_offset*(i-cursor.scroll))
      screen.text('>')
    end
    -- draw event for each step
    vui.screen_normal()
    vui.move(col_start,vui.row_offset*(i-cursor.scroll)) 
    -- draw time for each step
    vui.move(col_start+78,vui.row_offset*(i-cursor.scroll)) 
    screen.text(t.time[i])
  end
  
  screen.level(cursor.level)
  vui.rect(col_start,math.floor(cursor.y-1)*vui.row_offset,112, vui.row_offset)
  screen.stroke()
  
  screen.update()
end

local enc_mode = 0

function enc(n,d)
  if enc_mode == 0 then
    if n == 1 then
      cursor.scroll = util.clamp((cursor.scroll + d), 0, 6)
    elseif n == 2 then
      cursor.x = util.clamp((cursor.x + d*0.2), 1,6)
    elseif n == 3 then
      cursor.y = util.clamp((cursor.y + d*0.4), 1,10)
      if cursor.y <= 1 or cursor.y >= 10 then
        cursor.scroll = util.clamp((cursor.scroll + d), 0, 6)
      end
    end
  elseif enc_mode == 1 then
    if n == 1 then
      -- change mode/page
    end
    if (math.floor(cursor.x)) % 2 == 0 then
      if n == 2 then
        -- fx.val = fx.val + d
      elseif n == 3 then
        -- fx.effect = fx.effect + d
      end
    else
      if n == 2 then
        -- note.pitch = fx.val + d
      elseif n == 3 then
        -- note.inst = fx.effect + d
      end
    end
  end
end

function key(n,z)
  if n == 1 then
    enc_mode = z
    cursor.level = (z * 4) + 6
    if n == 2 then
      -- clear_cell(cursor.x,cursor.y)
    elseif n == 3 then
      -- insert_noteoff(cursor.x,cursor.y)
    end
  elseif n == 2 then

    -- play/stop
    if t.play == 0 and z == 1 then
      t:start()
    elseif t.play == 1 and z == 1 then
      t:stop()
    end

  elseif n == 3 then
    -- if stopped, bang+andvance
    if t.play == 0 and z == 1 then
      t:bang()
    elseif t.play == 1 and z == 1 then
      t:reset()
    end
  end
end