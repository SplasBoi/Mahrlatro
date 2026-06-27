
SMODS.Joker{ --Nutella Sweep
    key = "nutellasweep",
    config = {
        extra = {
            uniqueplanetcardsused = 1
        }
    },
    loc_txt = {
        ['name'] = 'Nutella Sweep',
        ['text'] = {
            [1] = 'Gives {X:red,C:white}X0.25{} Mult per ',
            [2] = 'unique {C:planet}Planet{} card used this run.',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    
    loc_vars = function(self, info_queue, card)
        
    return {vars = {card.ability.extra.uniqueplanetcardsused + (((function() local count = 0; for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then count = count + 1 end end; return count end)() or 0)) * 0.25}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
            Xmult = card.ability.extra.uniqueplanetcardsused + ((function() local count = 0; for k, v in pairs(G.GAME.consumeable_usage) do if v.set == 'Planet' then count = count + 1 end end; return count end)()) * 0.25
            }
        end
    end
}