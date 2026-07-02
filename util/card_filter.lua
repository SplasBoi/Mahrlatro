local mod = SMODS.current_mod
local config = mod.config

local ban_non_mahrlatro_cards

function SMODS.current_mod.reset_game_globals(run_start)
    if config.mahrlatr_cards_only then
        ban_non_mahrlatro_cards()
    end
end

ban_non_mahrlatro_cards = function()
    for k, v in pairs(G.P_CENTERS) do
        if v.set == 'Joker' then
            if not v.mod or v.mod.id ~= mod.id then
                G.GAME.banned_keys[k] = true
            end
        end
    end
end
