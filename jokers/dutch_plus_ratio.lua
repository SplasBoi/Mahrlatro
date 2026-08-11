local get_mult = nil

SMODS.Joker {
    key = "dutch_plus_ratio",

    pos = {
        x = 5,
        y = 5
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    cost = 5,
    rarity = 'mahrlatr_krejsi_rarity',
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    config = {
        extra = {
            -- Epic Weed
            epic_weed_mult = 3,

            -- Vaalserberg
            vaalserberg_chip_mod = 322,
            vaalserberg_h_size = 2,

            -- Sea Level
            sea_level_scaling = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                colours = {
                    G.C.SUITS["Clubs"]
                },

                -- Epic Weed
                e.epic_weed_mult,

                -- Vaalserberg
                e.vaalserberg_chip_mod,
                e.vaalserberg_h_size,
                
                -- Sea Level
                e.sea_level_scaling,
                G.GAME.starting_deck_size,
                get_mult(G.GAME.starting_deck_size),
            }
        }
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.vaalserberg_h_size)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.vaalserberg_h_size)
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.individual and context.cardarea == G.play then
            -- Epic Weed
            if context.other_card:is_suit("Clubs") then
                return {
                    mult = e.epic_weed_mult,
                }
            end
        end

        if context.joker_main then
            return {
                mult = get_mult(G.GAME.starting_deck_size), -- Sea Level
                chips = e.vaalserberg_chip_mod -- Vaalserberg
            }
        end
    end
}

get_mult = function(starting_number)
    if (not G.playing_cards) then return 0 end

    local deck_size = #G.playing_cards

    if deck_size <= starting_number then
        return starting_number - deck_size
    else
        return 0
    end
end