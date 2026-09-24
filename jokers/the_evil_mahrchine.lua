local function reset_suit(card)
    local suits = {}
    
    for _, suit_key in ipairs({ "Spades", "Hearts", "Clubs", "Diamonds" }) do
        if suit_key ~= card.ability.extra.debuffed_suit then
            suits[#suits + 1] = suit_key
        end
    end

    local suit = pseudorandom_element(suits, card.config.center.key .. card.unique_val)
    
    return suit
end

local rounded_decimals = 0

SMODS.Joker {
    key = "the_evil_mahrchine",

    discovered = false,
    unlocked = true,
    atlas = "CustomJokers",

    pos = {
        x = 0,
        y = 6
    },

    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    rarity = 1,
    cost = 5,

    config = {
        extra = {
            payout_percent = 75,
            debuffed_suit = ""
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                colours = { G.C.SUITS[e.debuffed_suit] },

                e.payout_percent,
                localize(e.debuffed_suit, "suits_plural"),
            }
        }
    end,

    update = function(self, card, dt)
        local e = card.ability.extra

        if card.added_to_deck then 
            for _, card_area in ipairs({ G.deck, G.hand }) do
                if card_area then
                    for _, v in ipairs(card_area.cards) do
                        if v:is_suit(e.debuffed_suit) then
                            v:set_debuff(true)
                        end
                    end
                end
            end
        end
	end,

    set_ability = function(self, card, initial, delay_sprites)
        local e = card.ability.extra

        if initial then
            e.debuffed_suit = reset_suit(card)
        end
    end,

    calc_dollar_bonus = function(self, card)
        local e = card.ability.extra

        local payout_mod = e.payout_percent / 100.0
        local payout = round_number(G.GAME.blind.dollars * payout_mod, rounded_decimals)

        return payout
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.end_of_round and not context.game_over and context.main_eval and not context.blueprint then
            e.debuffed_suit = reset_suit(card)
        end
    end,

    joker_display_def = function(JokerDisplay)
        return {
            reminder_text = {
                { text = "(" },
                {
                    ref_table = "card.joker_display_values",
                    ref_value = "debuffed_suit"
                },
                { text = ")" },
            },

            calc_function = function(card)
                local e = card.ability.extra

                card.joker_display_values.debuffed_suit = localize(e.debuffed_suit, "suits_plural")
            end,

            style_function = function(card, text, reminder_text, extra)
                local e = card.ability.extra

                if reminder_text and reminder_text.children[2] then
                    reminder_text.children[2].config.colour = lighten(G.C.SUITS[e.debuffed_suit], 0.35)
                end
            end
        }
    end
}