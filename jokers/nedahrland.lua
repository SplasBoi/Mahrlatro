SMODS.Joker {
    key = "nedahrland",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 4 },
    config = { extra = { dollars = 1 } },
    atlas = 'CustomJokers',
    pools = { ["modprefix_mahrlatr_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,


calculate = function(self, card, context)
        if context.first_hand_drawn  then
            if ((function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_mahrlatr_vaalserberg" then 
                        return true
                    end
                end
            end)() and (function()
                for i, v in pairs(G.jokers.cards) do
                    if v.config.center.key == "j_mahrlatr_epic_weed" then 
                        return true
                    end
                end
            end)()) then
                return {
                    func = function()
                        
                        local created_joker = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_mahrlatr_dutch_plus_ratio' })
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
                                if joker.config.center.key == "j_mahrlatr_vaalserberg" and not joker.getting_sliced then
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
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Merged!", colour = G.C.RED})
                            end
                            return true
                        end,
                        colour = G.C.RED,
                        extra = {
                            func = function()
                                local target_joker = nil
                                for i, joker in ipairs(G.jokers.cards) do
                                    if joker.config.center.key == "j_mahrlatr_epic_weed" and not joker.getting_sliced then
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
                                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Merged!", colour = G.C.RED})
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
                                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Merged!", colour = G.C.RED})
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
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Diamonds") then
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars + card.ability.extra.dollars
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(1), colour = G.C.MONEY})
                        return true
                    end
                }
            end
        end
    end
}