MahrMath = {}

function MahrMath.round(x, decimals)
    local mult  = 10 ^ (decimals or 0)
    if x >= 0 then
        return math.floor(x * mult + 0.5) / mult
    else
        return math.ceil(x * mult - 0.5) / mult
    end
end