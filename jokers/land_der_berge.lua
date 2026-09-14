local function get_mult(playing_cards, starting_number)
    if not playing_cards or type(playing_cards) ~= "table" or type(starting_number) ~= "number"  then
        return 0
    end

    local deck_size = #playing_cards

    if deck_size >= starting_number then
        return deck_size - starting_number
    else
        return 0
    end
end

SMODS.Joker {
    key = "land_der_berge",

    pos = {
        x = 4,
        y = 3
    },

    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 5,
    rarity = 2,

    config = {
        extra = {
            scaling = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra or self.config.extra

        return {
            vars = {
                colours = { HEX('C8102E') },
                
                e.scaling,
                G.GAME.starting_deck_size,
                get_mult(G.playing_cards, G.GAME.starting_deck_size),
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = get_mult(G.playing_cards, G.GAME.starting_deck_size)
            }
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            text = {
                { text = "+" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "mult",
                }
            },
            text_config = { colour = G.C.RED },

            calc_function = function(card)
                local e = card.ability.extra
                card.joker_display_values.mult = get_mult(G.playing_cards, G.GAME.starting_deck_size)
            end
        }
    end
}