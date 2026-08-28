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
function JokerUtility.instantiate_joker(joker_key) --> Card
    return SMODS.add_card({ set = 'Joker', key = joker_key })
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

--[[
context = Current context -> context
card = Card object -> Card
new_joker = Key of the joker to be instanced -> string
custom_color = Color of the message effect, pass nil for standard color -> HEX color or nil
slice_message = Message show when a joker is sliced, pass nil for no message -> string or nil
instantiation_message = Message shown when new joker is instanced, pass nil for no message -> string or nil
]]
function JokerUtility.slice_and_merge_jokers(context, card, new_joker, custom_color, slice_message, instantiation_message) --> void
    local e = card.ability.extra
    local sliced_joker

    for _, v in ipairs(e.required_jokers_to_merge) do
        for _, joker in ipairs(G.jokers.cards) do
            -- If it detects a joker already being sliced. Doesn't mark it to be sliced again (nil).
            if joker.config.center.key == v and not joker.getting_sliced then
                sliced_joker = joker
                break
            end
        end

        if sliced_joker == nil then return end

        sliced_joker.getting_sliced = true
        JokerUtility.slice_joker(sliced_joker)
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
            message = slice_message or "Merged!",
            colour = custom_color or G.C.ATTENTION
        })
    end
    
    -- Ends it there if sliced_joker is nil, which means it is already being sliced, so  shouldn't be again.
    if sliced_joker == nil then return end

    JokerUtility.slice_joker(card)
    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
        message = slice_message or "Merged!",
        colour = custom_color or G.C.ATTENTION
    })
    
    -- New Joker Instantiation
    JokerUtility.instantiate_joker(new_joker)

    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
        message = instantiation_message or "Merged!",
        colour = custom_color or G.C.ATTENTION
    })
        
    return true
end

-- Argument 1 is the list of jokers owned (G.jokers.cards) -> table
-- Argument 2 is the key of the joker we are checking for -> string
function JokerUtility.has_dupe(jokers_owned, key) --> bool
    local jokers = {}

    for _, joker in ipairs(jokers_owned) do
        if TableUtility.contains_individual(key, jokers) then return true end
        
        table.insert(jokers, joker.config.center.key)
    end

    return false
end

-- Argument 1 is the key is the list of jokers owned (G.jokers.cards) -> table
-- Argument 2 is the key of the joker we are looking for -> string
function JokerUtility.player_has_joker(jokers_owned, key) --> bool
    for _, joker in ipairs(jokers_owned) do
        if joker.config.center.key == key then
            return true
        end
    end

    return false
end