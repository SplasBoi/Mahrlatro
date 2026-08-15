local reset_suit = nil
local rounded_decimals = 0

SMODS.Joker {
    key = "the_evil_mahrchine",

    discovered = false,
    unlocked = true,
    atlas = 'CustomJokers',

    pos = {
        x = 0,
        y = 6
    },

    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    rarity = 1,
    cost = 5,

    config = {
        extra = {
            payout_increase = 75,
            debuffed_suit = 'Spades'
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                colours = { G.C.SUITS[e.debuffed_suit] },

                e.payout_increase,
                localize(e.debuffed_suit, 'suits_plural'),
            }
        }
    end,

    update = function(self, card, dt)
		if G.deck and card.added_to_deck then
			for i, v in pairs(G.deck.cards) do
				if v:is_suit(card.ability.extra.debuffed_suit) then
					v:set_debuff(true)
				end
			end
		end
		if G.hand and card.added_to_deck then
			for i, v in pairs(G.hand.cards) do
				if v:is_suit(card.ability.extra.debuffed_suit) then
					v:set_debuff(true)
				end
			end
		end
	end,

    calc_dollar_bonus = function(self,card)
        local payout = round_number(G.GAME.blind.dollars * 0.75, rounded_decimals)

        return payout
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.debuffed_suit = reset_suit(card.ability.extra.debuffed_suit)
        end
    end
}

reset_suit = function(debuffed_suit)
    local suits = {}
    
    for _, suit_key in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if suit_key ~= debuffed_suit then suits[#suits + 1] = suit_key end
    end

    local suit = pseudorandom_element(suits, 'j_mahrlatr_the_evil_mahrchine' .. G.GAME.round_resets.ante)
    
    return suit
end