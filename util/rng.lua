RNG = {}

-- For 1 in (chance) rolls.
function RNG.roll_chance(chance)
    local r = math.random(1, chance)
    print(r)

    return r == chance
end