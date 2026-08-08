local get_new_score_requirement = nil
local change_score_requirement = nil

SMODS.Blind {
    key = "themahrchine",

    dollars = 8,
    mult = 2,

    pos = {
        x = 1,
        y = 0
    },

    boss = {
        min = 1,
        max = 26,
        showdown = true,
    },

    boss_colour = HEX("D95C91"),

    set_blind = function(self, reset, silent)
        local original_score = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
        
        change_score_requirement(
            get_new_score_requirement(original_score)
        )
	end,

    disable = function(self, silent)
        local original_score = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2

        change_score_requirement(
            get_blind_amount(original_score)
        )
    end,
    
    calculate = function(self, card, context)
        if context.hand_drawn then
            local original_score = get_blind_amount(G.GAME.round_resets.ante) * G.GAME.starting_params.ante_scaling * 2
            
            change_score_requirement(
                get_new_score_requirement(original_score)
            )
        end
    end
}

get_new_score_requirement = function(base_score)
    -- Hardcoded until I find out how to set blind variables just like joker variables.
    local random_xmult = 1.0 + math.random() * 1.0

    return base_score * random_xmult
end

change_score_requirement = function(new_score)
    G.GAME.blind.chips = new_score
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
end