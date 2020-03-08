local softsamp = {}

function softsamp.init()
    -- softcut stuff
end

function softsamp.newInstTable()
    local t = {}
    return t 
end

softsamp.instEntry = {
    name = nil, 
    istart = 0.0,
    iend = 0.0, 
}

function softsamp.createInst(instTable, file, name)
    -- get sample length from file
end

return softsamp