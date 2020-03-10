local traxstr = {}

function traxstr.validateNoteTable(t)
    for k,v in ipairs(t) do
        local p, o, i
        if string.match(v, "----") then
            -- print ("cell empty")
        else
            p = string.sub(v,1,2)
            o = string.sub(v,3,3)
            i = string.sub(v,4,4)
            t[k].pitch = p
            t[k].oct = o
            t[k].inst = i
        end
    end
    t.validNote=true
end

function traxstr.validateFXTable(t)
    for k,v in ipairs(t) do
        local z, z1, z2
        if string.match(v, "----") then
            -- print("cell emptpy")
        else
            z = string.sub(v,1,1)
            z1 = string.sub(v,2,2)
            z2 = string.sub(v,3,3)
            t[k].effect = z
            t[k].param1 = z1
            t[k].param2 = z2
        end
    end
    t.validFX=true
end

return traxstr