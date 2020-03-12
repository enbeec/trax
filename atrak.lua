--- trak

engine.name = 'Timber'
local timb = include("timber/lib/timber_engine")
local MusicUtil = require 'musicutil'

trak = include("trax/lib/trak")

local t = {}

function init()
    
    timb.add_params()
    for i = 0,3 do
        params:add_separator()
        timb.add_sample_params(i)
    end
  
  
    timb.load_sample(0 ,_path.audio .. "common/808/808-BD.wav")
    
    engine.noteOn(0,MusicUtil.note_num_to_freq(60),60,0)
end
