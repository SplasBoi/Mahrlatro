SMODS.Joker { --Mahrffin
    key = "mahrffin",

    config = {
        extra = {
            dollars = 1
        }
    },
    
    pos = {
        x = 0,
        y = 2
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 4,
    rarity = 1,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,
    
    calculate = function(self, card, context)
        if context.before then
            return {
                func = function()
                    ease_dollars(card.ability.extra.dollars)
                    card_eval_status_text(
                        context.blueprint_card or card,
                        'extra',
                        nil,
                        nil,
                        nil,
                        {
                            message = "+$".. card.ability.extra.dollars,
                            colour = G.C.MONEY
                        }
                    )
                    return true
                end
            }
        end
        if context.first_hand_drawn  then
            if ((function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_mahrlatr_mahrffin" then 
                        return true
                    end
                end
            end)() and (function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_mahrlatr_fish" then 
                        return true
                    end
                end
            end)() and (function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_mahrlatr_meat" then 
                        return true
                    end
                end
            end)()) then
                return {
                    func = function()
                        
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mahrlatr_mahrbles_trolley' })
                                if joker_card then
                                    
                                    
                                end
                                
                                return true
                            end
                        }))
                        
                        if created_joker then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            local target_joker = nil
                            for i, joker in ipairs(G.jokers.cards) do
                                if joker.config.center.key == "j_mahrlatr_fish" and not joker.getting_sliced then
                                    target_joker = joker
                                    break
                                end
                            end
                            
                            if target_joker then
                                if target_joker.ability.eternal then
                                    target_joker.ability.eternal = nil
                                end
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Collected!", colour = G.C.RED})
                            end
                            return true
                        end,
                        colour = G.C.RED,
                        extra = {
                            func = function()
                                local target_joker = nil
                                for i, joker in ipairs(G.jokers.cards) do
                                    if joker.config.center.key == "j_mahrlatr_meat" and not joker.getting_sliced then
                                        target_joker = joker
                                        break
                                    end
                                end
                                
                                if target_joker then
                                    if target_joker.ability.eternal then
                                        target_joker.ability.eternal = nil
                                    end
                                    target_joker.getting_sliced = true
                                    G.E_MANAGER:add_event(Event({
                                        func = function()
                                            target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                            return true
                                        end
                                    }))
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Collected!", colour = G.C.RED})
                                end
                                return true
                            end,
                            colour = G.C.RED,
                            extra = {
                                func = function()
                                    local target_joker = card
                                    
                                    if target_joker then
                                        if target_joker.ability.eternal then
                                            target_joker.ability.eternal = nil
                                        end
                                        target_joker.getting_sliced = true
                                        G.E_MANAGER:add_event(Event({
                                            func = function()
                                                target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                                return true
                                            end
                                        }))
                                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Collected!", colour = G.C.RED})
                                    end
                                    return true
                                end,
                                colour = G.C.RED
                            }
                        }
                    }
                }
            end
        end
    end
}