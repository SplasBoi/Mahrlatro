SMODS.Joker {
    key = "black_mahrket",
    atlas = 'CustomJokers',
    unlocked = true,
    discovered = true,
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    pos = {
        x = 0,
        y = 13
    },

    config = {
        extra = {
            joker_destroy_count = 2
        }
    },

    rarity = 3,
    cost = 10,

    loc_vars = function(self, info_queue, card)
        local e = self.config.extra or card.ability.extra

        return {
            vars = {
                e.joker_destroy_count
            }
        }
    end,

    can_sell = function(self, card, context)
        local e = self.config.extra or card.ability.extra

        local jokers_in_hand = #G.jokers.cards
        local available_jokers = math.max(0, jokers_in_hand - e.joker_destroy_count - 1)

        return available_jokers > 0
    end,

    calculate = function(self, card, context)
        local e = self.config.extra or card.ability.extra

        if context.selling_self then
            local available_jokers = {}

            for _, v in ipairs(G.jokers.cards) do
                if v ~= card then
                    table.insert(available_jokers, v)
                end
            end

            if #available_jokers < 3 then
                return
            end

            for i = #available_jokers, 2, -1 do
                local j = math.random(i)
                available_jokers[i], available_jokers[j] = available_jokers[j], available_jokers[i]
            end

            local a, b, c = available_jokers[1], available_jokers[2], available_jokers[3]

            for _, v in ipairs({a, b}) do
                SMODS.destroy_cards(v)
            end
            
            c:set_edition({ negative = true }, true)
        end
    end
}