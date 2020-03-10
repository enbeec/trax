-- softsamp can be used to create
--      a fresh instrument table
--      or allocate an exisiting
--      table to a specified
--      softcut buffer
local softsamp = {}

local util = require('util')

local instrument_mt = {
    -- __index = function(t,k)
    --     print("inst " .. k .. " does not exist")
    -- end
}

function softsamp.init(buffer,instTable)
    -- softcut init stuff
    buffer = buffer or 1
    softcut.buffer_clear_channel(buffer)
    for i=1,3 do -- one voice for each channel
        softcut.enable(i,1)
    end
    -- build/load instrument table
    local it = instTable or {inst={}}
    it.inst = setmetatable(it.inst, instrument_mt)
    it.softcut = {
        buffer = buffer,
        [1] = 1, 
        [2] = 2,
        [3] = 3
    }
    return it
end

local mi_length = 'mediainfo --Inform="Audio;%Duration%" '
local inst_pad = 0.4

function softsamp.newInst(itable,name,file) -- TODO: default_volume
    local t = {}
    local s, e, l, sr
    _, l, sr = audio.file_info(file)
    l = (l / sr / 1000)
    local highe = 1
    for _,v in ipairs(itable.inst) do
       if v.iend > highe then
            highe = v.iend
       end
    end
    s = 0.0 + highe
    e = s + l + inst_pad
    -- TODO: check if there's space left
    softcut.buffer_read_mono(file, 0.0, s, l, 1, itable.softcut.buffer)
    t.sourcefile = file
    t.istart = s
    t.iend = e
    t.ilength = l
    return t
end

function softsamp.rate(oct,pitch)
    -- TODO: ...this
    return 1.0
end

function softsamp.play(itable,inst,chan,oct,pitch)
    local c = 1 -- channel
    
    -- softcut.position()
    -- softcut.rate()
    softcut.play(c,1)
    local x
    x = metro.init(
        function ()
            softcut.play(c,0)
            metro.free(x.id)
        end, 
        l, 1
    )
    -- TODO: noteoff support
end

return softsamp