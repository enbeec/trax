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

function init()
  for i=1,3 do
    trax[i].note = c.newBlank(4)
    trax[i].fx = c.newBlank(3)
  end
  
  ruler.hex = c.newHex() 
  
  re=metro.init()
  re=metro.init()
	re.time = 1.0/15
	re.event = function()
	  redraw()
	end
	
	screen_init()
	re:start()
end

function screen_init()
  screen.aa(1)
end

---

local vui = include("lib/vui")

local scroll = 0
local hx,hy = 1,1
local hl_level = 6

function redraw()
  screen.clear()
  
  for i=1,16 do
    
    -- COL 1 -- HEX
    vui.screen_ruler()
    fx_move(vui.column_positions[1],vui.row_offset*(i-scroll)) 
    screen.text(ruler.hex[i])
    
    -- COL 2,3 -- NOTE 1,FX 1
    vui.screen_normal()
    fx_move(vui.column_positions[2],vui.row_offset*(i-scroll)) 
    screen.text(trax[1].note[i])
    fx_move(vui.column_positions[3],vui.row_offset*(i-scroll)) 
    screen.text(trax[1].fx[i])
    
    -- COL 4 -- RULER 1
    vui.screen_ruler()
    fx_move(vui.column_positions[4],vui.row_offset*(i-scroll))
    screen.text(
      c.four_four.takadimi[i])
    
    -- COL 5,6 -- NOTE 2,FX 2
    vui.screen_normal()
    fx_move(vui.column_positions[5],vui.row_offset*(i-scroll)) 
    screen.text(trax[2].note[i])
    fx_move(vui.column_positions[6],vui.row_offset*(i-scroll)) 
    screen.text(trax[2].fx[i])
    
    -- COL 7 -- RULER 2
    vui.screen_ruler()
    fx_move(vui.column_positions[7],vui.row_offset*(i-scroll)) 
    screen.text(c.four_four.sixteenth[i])
    
    -- COL 8,9 -- NOTE 3,FX 3
    vui.screen_normal()
    fx_move(vui.column_positions[8],vui.row_offset*(i-scroll)) 
      screen.text(trax[3].note[i])
    fx_move(vui.column_positions[9],vui.row_offset*(i-scroll)) 
    screen.text(trax[3].fx[i])
  end 
  
  -- OPERATIONS THAT USE THIS RECTANGLE AS THEIR TARGET NEED TO OPEPRATE ON (X,Y+SCROLL)
  -- THE HIGHLIGHT RECTANGLE IS NOT TIED TO TABLE POSITION
  -- IT IS TIED TO SCREEN POSITION
  screen.level(hl_level)
  if (math.floor(hx)) % 2 == 0 then
    fx_rect(
      vui.column_positions[vui.selectables[math.floor(hx)]],
      vui.row_offset*(math.floor(hy)-1),
      12, vui.row_offset)
  else
    fx_rect(
      vui.column_positions[vui.selectables[math.floor(hx)]], 
      vui.row_offset*(math.floor(hy)-1),
      16, vui.row_offset)
  end
  screen.stroke()
  
  screen.update()
end


function fx_move(x,y,fx)
  local xscale,yscale = 1,1
  -- TODO: what if i made everything wiggle by doing something fun in here
  screen.move(x*xscale,y*yscale) 
end

function fx_rect(x,y,w,h)
  local xscale,yscale = 1,1
  -- TODO: what if i made rectangles move around by doing something fun in here
  screen.rect(x*xscale,y*yscale,w,h) 
end

local enc_mode = 0
local edit_flag = 0

function enc(n,d)
  if enc_mode == 0 then
    if n == 1 then
      scroll = util.clamp((scroll + d), 0, 6)
    elseif n == 2 then
      hx = util.clamp((hx + d*0.2), 1,6)
    elseif n == 3 then
      hy = util.clamp((hy + d*0.4), 1,10)
    end
  elseif enc_mode == 1 then
    if n == 1 then
      -- change mode
    end
    if (math.floor(hx)) % 2 == 0 then
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
    hl_level = (z * 4) + 6
    if n == 2 then
      -- clear_cell(hx,hy)
    elseif n == 3 then
      -- insert_noteoff(hx,hy)
    end
  elseif n == 2 then
    -- play/stop
  elseif n == 3 then
    -- bang+andvance
  end
end