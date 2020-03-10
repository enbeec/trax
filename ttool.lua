-- trax
-- 
-- a tracker with
-- easy to use rulers for
-- all sorts of tracking
--      scenarios
--
-- TODO: lots of stuff,
--       incl a softcut sampler
--       and a way to read rows
--       and a master metro...
--
-- TODO: add custom rulers
--       maybe chord progs
--       ill hardcode some first
--

engine.name = "TestSine"

local c = include("lib/counts")

trax = { {},{}, {} }
local ruler = {}

--- TRACKER

function play(itable,tstr)
  
end

--- INIT

function init()
  for i=1,3 do
    trax[i].note = c.newBlank(4)
    trax[i].fx = c.newBlank(3)
  end
  
  ruler.hex = c.newHex() 
  
  refreshmaker()
end

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

--- USER INTERFACE

-- factored away my aesthetic choices~
local vui = include("lib/vui")

-- OPERATIONS THAT USE THIS THE CURSOR AS THEIR TARGET 
-- NEED TO OPEPRATE ON (X,Y+SCROLL)
-- THE HIGHLIGHT RECTANGLE IS NOT TIED TO TABLE POSITION
-- IT IS TIED TO SCREEN POSITION
local cursor = {
  scroll = 0,
  x = 1, y = 1,
  level = 6
}

function redraw()
  screen.clear()
  
  for i=1,16 do
    
    -- COL 1 -- HEX
    vui.screen_ruler()
    vui.move(vui.column_positions[1],vui.row_offset*(i-cursor.scroll)) 
    screen.text(ruler.hex[i])
    
    -- COL 2,3 -- NOTE 1,FX 1
    vui.screen_normal()
    vui.move(vui.column_positions[2],vui.row_offset*(i-cursor.scroll)) 
    screen.text(trax[1].note[i])
    vui.move(vui.column_positions[3],vui.row_offset*(i-cursor.scroll)) 
    screen.text(trax[1].fx[i])
    
    -- COL 4 -- RULER 1
    vui.screen_ruler()
    vui.move(vui.column_positions[4],vui.row_offset*(i-cursor.scroll))
    screen.text(c.four_four.takadimi[i])
    
    -- COL 5,6 -- NOTE 2,FX 2
    vui.screen_normal()
    vui.move(vui.column_positions[5],vui.row_offset*(i-cursor.scroll)) 
    screen.text(trax[2].note[i])
    vui.move(vui.column_positions[6],vui.row_offset*(i-cursor.scroll)) 
    screen.text(trax[2].fx[i])
    
    -- COL 7 -- RULER 2
    vui.screen_ruler()
    vui.move(vui.column_positions[7],vui.row_offset*(i-cursor.scroll)) 
    screen.text(c.four_four.sixteenth[i])
    
    -- COL 8,9 -- NOTE 3,FX 3
    vui.screen_normal()
    vui.move(vui.column_positions[8],vui.row_offset*(i-cursor.scroll)) 
      screen.text(trax[3].note[i])
    vui.move(vui.column_positions[9],vui.row_offset*(i-cursor.scroll)) 
    screen.text(trax[3].fx[i])
  end 
  
  screen.level(cursor.level)
  if (math.floor(cursor.x)) % 2 == 0 then
    vui.rect(
      vui.column_positions[vui.selectables[math.floor(cursor.x)]],
      vui.row_offset*(math.floor(cursor.y)-1),
      12, vui.row_offset)
  else
    vui.rect(
      vui.column_positions[vui.selectables[math.floor(cursor.x)]], 
      vui.row_offset*(math.floor(cursor.y)-1),
      16, vui.row_offset)
  end
  screen.stroke()
  
  screen.update()
end

--- ENCODERS AND KEYS

local enc_mode = 0
local edit_flag = 0

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
  elseif n == 3 then
    -- bang+andvance
  end
end