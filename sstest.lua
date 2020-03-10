-- softsamp test
--
-- a test for softsamp 

engine.name = "TestSine"

local softsamp = include("lib/softsamp")
local tu = require 'tabutil'

local it = {}

local samples = {
    val = "val/",
    kick1 = "kicks_48k/dhh2_kick_oneshot_low_deep_rumble_48k.aif",
}

function init()
    it = softsamp.init(1)
    it.inst.kick = softsamp.newInst(it, 
        "kick", _path.audio .. samples.val .. samples.kick1)
    tu.print(it.inst) 
end