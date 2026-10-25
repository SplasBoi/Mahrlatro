JokerUtility = {}

-- Argument 1 is the key we are looking for. -> string
-- Returns how many copies of a joker player has
function JokerUtility.jokers_owned(key) --> number
    if not G.jokers then return 0 end

    local count = 0

    for _, joker in ipairs(G.jokers.cards) do
        if joker.config.center.key == key then
            count = count + 1
        end
    end
    
    return count
end

-- Argument 1 is an array of the joker keys to be merged -> table
function JokerUtility.can_merge_jokers(joker_keys) --> bool
    if not G.jokers then return false end
    
    local jokers = {}

    for i, v in ipairs(joker_keys) do
        jokers[i] = {
            key = v,
            found = false
        }
    end

    for i, v in ipairs(joker_keys) do
        if (JokerUtility.jokers_owned(v) > 0) then jokers[i].found = true end
    end

    for _, v in pairs(jokers) do
        if not v.found then
            return false
        end
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


--card = Card object -> Card
--new_joker = Key of the joker to be instanced -> string
--sliced_jokers = Table containing jokers to be sliced -> table
--custom_color = Color of the message effect, pass nil for standard color -> HEX color or nil
--slice_message = Message shown when a joker is sliced, pass nil for default message -> string or nil
--instantiation_message = Message shown when new joker is instanced, pass nil for default message -> string or nil
function JokerUtility.slice_and_merge_jokers(card, new_joker, sliced_jokers, custom_color, slice_message, instantiation_message) --> void
    local e = card.ability.extra
    local sliced_joker

    for _, v in ipairs(sliced_jokers) do
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
        card_eval_status_text(card, 'extra', nil, nil, nil, {
            message = slice_message or "Merged!",
            colour = custom_color or G.C.ATTENTION
        })
    end
    
    -- Ends it execution if sliced_joker is nil, which means current joker has already been sliced.
    if sliced_joker == nil then return end
    
    -- New Joker Instantiation
    local new_card = JokerUtility.instantiate_joker(new_joker)

    card_eval_status_text(new_card, 'extra', nil, nil, nil, {
        message = instantiation_message or "Merged!",
        colour = custom_color or G.C.ATTENTION
    })
        
    return true
end

function JokerUtility.is_in_blind()
    return G.GAME.blind
       and G.GAME.blind.in_blind
        or G.STATE == G.STATES.SELECTING_HAND
        or G.STATE == G.STATES.HAND_PLAYED
        or G.STATE == G.STATES.DRAW_TO_HAND
end

function JokerUtility.is_wild_card(card)
    return card and SMODS.has_enhancement(card, "m_wild")
end

function JokerUtility.is_stone_card(card)
    return card and (SMODS.has_enhancement(card, "m_stone") or SMODS.has_enhancement(card, "m_mahrlatr_pink_stone"))
end

function JokerUtility.get_random_poker_hand(card)
    local current_hand = card.ability.extra.poker_hand or ""
    local poker_hands = {}

    for handname, _ in pairs(G.GAME.hands) do
        if SMODS.is_poker_hand_visible(handname) and handname ~= current_hand then
            table.insert(poker_hands, handname)
        end
    end
    
    return pseudorandom_element(poker_hands, card.config.center_key .. card.unique_val)
end