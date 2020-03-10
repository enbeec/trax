-- sosat
-- SOftcut
-- SAmpler Test

-- globals
sosa = include("lib/sosa")
tu = require 'tabutil'

-- vars
local it = {} -- instrument table

local samples = { -- convenience
    val = "val/",
    kick1 = "kicks_48k/dhh2_kick_oneshot_low_deep_rumble_48k.aif",
}

-- init
function init()
    it = softsamp.newTable(1)
    -- add kick
    -- play kick

-- redraw

-- enc/key