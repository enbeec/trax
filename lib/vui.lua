local vui = {}

vui.column_positions = {
  0, -- HEX 
  12, -- N1
  30, -- F1
  44, -- R1
  56, -- N2
  74, -- F2
  89, -- R2
  97, -- N3
  115 -- F3
}

vui.selectables = { 2, 3, 5, 6, 8, 9 }
vui.row_offset = 6

function vui.new()
  return vui
end

function vui.screen_ruler(level)
  level = level or 6
  screen.level(level)
  screen.font_face(0)
  screen.font_size(8)
end

function vui.screen_normal(level)
  level = level or 10
  screen.level(level)
  screen.font_face(1)
  screen.font_size(8)
end

function vui.move(x,y,fx)
  local xscale,yscale = 1,1
  -- TODO: what if i made everything wiggle by doing something fun in here
  screen.move(x*xscale,y*yscale) 
end

function vui.rect(x,y,w,h)
  local xscale,yscale,wscale,hscale = 1,1,1,1
  -- TODO: what if i made rectangles move around by doing something fun in here
  screen.rect(x*xscale,y*yscale,w*wscale,h*hscale) 
end

return vui