local add_tarot_card = nil
local free_consumeable_slots = nil

SMODS.Joker {
    key = "face_monstahr",

    pos = {
        x = 6,
        y = 15
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
    rarity = 1,

    config = {
        extra = {
            numerator = 1,
            denominator = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = self.config.extra or card.ability.extra
        local num, denom = SMODS.get_probability_vars(card, e.numerator, e.denominator)

        return {
            vars = {
                num,
                denom
            }
        }
    end,

    calculate = function(self, card, context)
        local e = self.config.extra or card.ability.extra

        if context.discard and context.other_card:is_face() then
            if SMODS.pseudorandom_probability(card, self.key, e.numerator, e.denominator) then
                if free_consumeable_slots() > 0 then
                    return {
                        extra = {
                            message = localize('k_plus_tarot'),
                            message_card = card,
                            func = add_tarot_card(self)
                        }
                    }
                end
            end
        end
    end
}

add_tarot_card = function(self)
    G.E_MANAGER:add_event(Event({
        trigger = "immediate",
        func = function()
            SMODS.add_card {
                set = 'Tarot',
                key_append = self.key
            }
            return true
        end
    }))
end

free_consumeable_slots = function()
    local consumeables = #G.consumeables.cards
    local consumeable_limit = G.consumeables.config.card_limit

    return math.max(0, consumeable_limit - consumeables)
end