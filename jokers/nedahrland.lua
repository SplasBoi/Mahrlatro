local has_jokers = nil
local create_joker = nil

SMODS.Joker {
    key = "nedahrland",
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 0, y = 4 },
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = {
        extra = {
            dollars = 1,
            merging = false,
            external_jokers = {
                "j_mahrlatr_vaalserberg",
                "j_mahrlatr_epic_weed"
            }
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if context.other_card:is_suit("Diamonds") then
                return {
                    func = function()
                        local money = card.ability.extra.dollars
                        ease_dollars(money)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                        {
                            message = "+".. money,
                            colour = G.C.MONEY}
                        )
                    end
                }
            end
        end

        if context.first_hand_drawn then
            if not card.ability.extra.merging and has_jokers(card.ability.extra.external_jokers) then
                card.ability.extra.merging = true

                return {
                    extra = {
                        func = function()
                            local joker_types_to_destroy = {}
                            for _, v in ipairs(card.ability.extra.external_jokers) do
                                table.insert(joker_types_to_destroy, v)
                            end
                            table.insert(joker_types_to_destroy, card.config.center.key)

                            for _, merge_joker_key in ipairs(joker_types_to_destroy) do
                                for _, joker in ipairs(G.jokers.cards) do
                                    if joker.config.center.key == merge_joker_key then

                                        if joker.ability.eternal then
                                            joker.ability.eternal = nil
                                        end
                                        
                                        joker.getting_sliced = true

                                        G.E_MANAGER:add_event(Event({
                                            trigger = "immediate",
                                            func = function()
                                                joker:start_dissolve(
                                                    {G.C.RED},
                                                    nil,
                                                    1.6
                                                )
                                                return true
                                            end
                                        }))

                                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
                                            message = localize("joker_merged"),
                                            colour = G.C.RED
                                        })
                                    end
                                end
                            end

                            create_joker("j_mahrlatr_dutch_plus_ratio")

                            return true
                        end
                    }
                }
            end
        end
    end
}

has_jokers = function(joker_keys)
    for _, key in ipairs(joker_keys) do
        local found_joker = false

        for _, joker in ipairs(G.jokers.cards) do
            if joker.config.center.key == key then
                found_joker = true
                break
            end
        end

        if not found_joker then
            return false
        end
    end

    return true
end

create_joker = function(joker_key)
    local dutch_plus_joker = nil
    G.E_MANAGER:add_event(Event({
        func = function()
            dutch_plus_joker = SMODS.add_card({
                trigger = "immediate",
                set = "Joker",
                key = joker_key
            })

            return true
        end
    }))

    if dutch_plus_joker then
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {
            message = localize("k_plus_joker"),
            colour = G.C.BLUE
        })
    end

    return dutch_plus_joker
end