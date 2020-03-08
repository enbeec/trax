local ui = {}

ui.column_positions = {
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

ui.selectables = { 2, 3, 5, 6, 8, 9 }
ui.row_offset = 6

function ui.new()
  return ui
end

function ui.screen_ruler(level)
  level = level or 6
  screen.level(level)
  screen.font_face(0)
  screen.font_size(8)
end

function ui.screen_normal(level)
  level = level or 10
  screen.level(level)
  screen.font_face(1)
  screen.font_size(8)
end

return ui