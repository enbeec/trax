local softsamp = {}

local instrument_mt = {}
    __index = function(t,k)
        print("inst " .. k .. " does not exist")
    end
    -- TODO: new instrument
end

function softsamp.init(buffer,instTable)
    -- softcut init stuff
    buffer = buffer or 1
    softcut.buffer_clear_channel(buffer)
    for i=1,3 do -- one voice for each channel
        softcut.enable(i,1)
    end
    -- build/load instrument table
    local it = instTable or {}
    it = setmetatable(it, instrument_mt)
    it.softcut = {
        buffer = buffer,
        [1] = 1, 
        [2] = 2,
        [3] = 3
    }
    return it
end

function softsamp.rate(oct,pitch)
    return 1.0
end

function softsamp.play(itable,inst,chan,oct,pitch)
    local c = itable.softcut[chan]
    local l = itable.inst.ilength
    softcut.position(c,it.inst.istart)
    softcut.rate(c,softsamp.rate(oct,pitch))
    softcut.play(c,1)
    -- TODO: (wait for l of isntrument or noteoff)
    softcut.play(c,0)
end

return softsamp