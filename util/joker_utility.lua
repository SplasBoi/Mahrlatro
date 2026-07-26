JokerUtility = {}

-- Argument 1 is the key we are looking for. -> string
function JokerUtility.owns_joker(key) --> bool
    for _, v in pairs(G.jokers.cards) do
        if key == v.config.center.key then return true end
    end

    return false
end


--Argument 1 is an array of the joker keys to be merged -> table
function JokerUtility.can_merge_jokers(joker_keys) --> bool
    local jokers = {}

    for i, v in ipairs(joker_keys) do
        jokers[i] = {
            key = v,
            found = false
        }
    end

    for i, v in ipairs(joker_keys) do
        if (JokerUtility.owns_joker(v)) then jokers[i].found = true end
    end

    for _, v in pairs(jokers) do
        if not v.found then return false end
    end

    return true
end

-- Argument 1 is the key of the joker we want to instantiate -> string
function JokerUtility.instantiate_joker(joker_key) --> void
    G.E_MANAGER:add_event(Event({
        func = function()
            SMODS.add_card({ set = 'Joker', key = joker_key })
            return true
        end
    }))
end

-- Argument 1 is the card object of the joker we want to slice -> Card object
function JokerUtility.slice_joker(card) --> void
    G.E_MANAGER:add_event(Event({
        func = function()
            card:start_dissolve({G.C.RED}, nil, 1.6)
            return true
        end
    }))
end