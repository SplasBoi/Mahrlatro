local get_random_card = nil

SMODS.Joker {
    key = 'the_leadahrboard',

    pos = {
        x = 1,
        y = 8
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
    rarity = 1,

    config = {
        extra = {
            mult = 10,
            random_rank = 'Ace'
        }
    },

    -- Gives 10 Mult if card with rank () is scored (idol at home)
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.random_rank
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.random_rank = get_random_card()
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.value == card.ability.extra.random_rank then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.random_rank = get_random_card()
        end
    end
}

get_random_card = function()
    local valid_cards = {}

    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end

    local selected_card = pseudorandom_element(valid_cards, 'j_mahrlatr_the_leadahrboard' .. G.GAME.round_resets.ante)
    if selected_card then
        return selected_card.base.value
    end
end