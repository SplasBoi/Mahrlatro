
SMODS.Joker{ --Wild Cat
    key = "wildcat",
    config = {
        extra = {
            wildcardsindeck = 1
        }
    },
    loc_txt = {
        ['name'] = 'Wild Cat',
        ['text'] = {
            [1] = 'Gives {X:red,C:white}X0.2{} Mult for every {C:attention}Wild card{}',
            [2] = 'currently in {C:gold}Full Hand{}.',
            [3] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["mahrlatr_mahrlatr_jokers"] = true },
    
    loc_vars = function(self, info_queue, card)
        
    return {vars = {card.ability.extra.wildcardsindeck + ((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if SMODS.has_enhancement(card, 'm_wild') then count = count + 1 end end; return count end)()) * 0.2}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
            Xmult = card.ability.extra.wildcardsindeck + ((function() local count = 0; for _, card in ipairs(G.playing_cards or {}) do if SMODS.has_enhancement(card, 'm_wild') then count = count + 1 end end; return count end)()) * 0.2
            }
        end
    end
}