local function tally_wilds(cards)
    if type(cards) ~= "table" then
        return 0
    end

    local count = 0
    
    for _, playing_card in ipairs(cards) do
        if JokerUtility.is_wild_card(playing_card) then
            count = count + 1
        end
    end

    return count
end

SMODS.Joker {
    key = "wild_cat",

    config = {
        extra = {
            xmult = 0.2
        }
    },

    pos = {
        x = 3,
        y = 0
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = false,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild

        return {
            vars = {
                e.xmult,
                1 + e.xmult * tally_wilds(G.playing_cards)
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = 1 + card.ability.extra.xmult * tally_wilds(G.playing_cards),
            }
        end
    end,

    in_pool = function(self, args)
        return tally_wilds(G.playing_cards) > 0
    end,

    check_for_unlock = function(self, args)
        return tally_wilds(G.playing_cards) >= 8
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        {
                            ref_table = "card.joker_display_values",
                            ref_value = "x_mult"
                        }
                    }
                }
            },

            text_config = { colour = G.C.WHITE },

            calc_function = function(card)
                local gained_mult = card.ability.extra.xmult * tally_wilds(G.playing_cards)
                card.joker_display_values.x_mult = 1 + gained_mult
            end
        }
    end
}