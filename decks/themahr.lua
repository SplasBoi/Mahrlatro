SMODS.Back {
    key = "themahr",

    atlas = "CustomBacks",
    pos = {
        x = 0,
        y = 0
    },

    unlocked = true,

    config = {
        extra = {
            seal = "mahrlatr_mahr",
            x_chips = 0.5
        }
    },

    apply = function(self, back)
        local e = self.config.extra

        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    local silent = true
                    local immediate = true
                    card:set_seal(e.seal, silent, immediate)
                end
                
                return true
            end
        }))
    end,

    calculate = function(self, back, context)
        local e = self.config.extra
        
        if context.final_scoring_step then
            return {
                x_chips = e.x_chips
            }
        end
    end
}