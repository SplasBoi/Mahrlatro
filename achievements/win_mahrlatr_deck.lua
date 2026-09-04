SMODS.Achievement {
    key = "win_mahrlatr_deck",
    earned = false,

    unlock_condition = function(self, args)
        if args.type == "win" then
            return string.sub(G.GAME.selected_back.name, 1, 11) == "b_mahrlatr_"
        end
        
        return false
    end
}