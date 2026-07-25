local get_x_mult = nil
local count_black_cards = nil

SMODS.Joker { --Scary Crimson
    key = "scary_crimson",

    pos = {
        x = 0,
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
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    cost = 4,
    rarity = 2,

    config = {
        extra = {
            x_mult = 0.0,
            scaling = 0.1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                colours = { HEX('000000') },
                
                card.ability.extra.scaling,
                get_x_mult(count_black_cards())
            }
        }
    end,

    calculate = function(self, card, context)
        if context.after then
            for _, v in ipairs(context.scoring_hand) do
                if (SuitHelpers.is_black_card(v)) then
                    local red_suits = {"Hearts", "Diamonds"}
                    local random_red_suit = red_suits[math.random(1,2)]

                    v:juice_up(0.3, 0.5) 
                    v:change_suit(random_red_suit)
                end
            end

            return {
                message = localize('scary_crimson_spreads')
            }
        end

        if context.joker_main then
            return {
                x_mult = get_x_mult(count_black_cards())
            }
        end
    end
}

get_x_mult = function(black_cards)
    return black_cards / 10
end

count_black_cards = function()
    if (not G.playing_cards) then return 0 end

    local black_cards_in_deck = 0

    for _, v in pairs(G.playing_cards) do
        if SuitHelpers.is_black_card(v) or SMODS.has_enhancement(v, 'm_wild') then
            black_cards_in_deck = black_cards_in_deck + 1
        end
    end

    return black_cards_in_deck
end