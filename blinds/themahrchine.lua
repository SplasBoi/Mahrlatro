local get_new_score_requirement = nil
local change_score_requirement = nil

SMODS.Blind {
    key = "themahrchine",

    dollars = 8,
    mult = 2,

    atlas = 'CustomBlinds',

    pos = {
        x = 0,
        y = 1
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
            get_new_score_requirement(original_score, G.GAME.chips)
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
                get_new_score_requirement(original_score, G.GAME.chips)
            )
        end
    end
}

get_new_score_requirement = function(base_score, current_score)
    -- Hardcoded until I find out how to set blind variables just like config joker variables.
    local min_xmult = 1.0
    local max_xmult = 2.0

    -- Bottom caps the score requirement so it doesn't go lower than the current score.
    if (current_score > base_score) then
        -- +0.01 so there is absolutely no chance of the new score being equal to the current score.
        min_xmult = current_score / base_score + 0.01
    end

    local random_xmult = min_xmult + math.random() * (max_xmult - min_xmult)

    return base_score * random_xmult
end

change_score_requirement = function(new_score)
    G.GAME.blind.chips = new_score
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
end