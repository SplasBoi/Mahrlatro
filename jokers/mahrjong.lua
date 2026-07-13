local has_x_pair = nil

SMODS.Joker {
    key = "mahrjong",

    discovered = true,
    unlocked = true,
    --atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },

    rarity = 2,
    cost = 4,

    config = {
        extra = {
            xmult = 3
        }
    },

    loc_vars = function(self, info_queue, card)
        local e = card.ability.extra

        return {
            vars = {
                e.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        local e = card.ability.extra

        if context.joker_main then
            local pair_count = 3
            if has_x_pair(context.scoring_hand, pair_count) then
                return {
                    xmult = e.xmult
                }
            end
        end
    end
}

has_x_pair = function(cards, pair_count)
    local rank_counts = {}

    for _, card in ipairs(cards) do
        local rank = card:get_id()
        rank_counts[rank] = (rank_counts[rank] or 0) + 1
    end

    for _, count in pairs(rank_counts) do
        if count >= pair_count then
            return true
        end
    end
end