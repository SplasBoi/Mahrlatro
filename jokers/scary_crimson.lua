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
    pools = { ["mahr_mahr_jokers"] = true },

    cost = 4,
    rarity = 1,

    config = {
        extra = {
            x_mult = 0.0,
            scaling = 0.1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,
                card.ability.extra.scaling
            }
        }
    end,

    calculate = function(self, card, context)
        card.ability.extra.x_mult = self:count_black_cards() / 10

        if context.after then
            for _, v in ipairs(context.scoring_hand) do
                if (HELPERS.is_black_card(v)) then
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
                x_mult = card.ability.extra.x_mult
            }
        end
    end,

    count_black_cards = function()
        local black_cards_in_deck = 0

        for k, v in pairs(G.playing_cards) do
            if HELPERS.is_black_card(v) or SMODS.has_enhancement(v, 'm_wild') then
                black_cards_in_deck = black_cards_in_deck + 1
            end
        end

        return black_cards_in_deck
    end
}