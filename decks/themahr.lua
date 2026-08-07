-- TODO: halve scored chips

SMODS.Back {
    key = "themahr",

    atlas = "CustomBacks",
    pos = {
        x = 1,
        y = 0
    },

    unlocked = true,

    config = {
        extra = {
            seal = "mahrlatr_mahr"
        }
    },

    apply = function(self, back)
        local conf = self.config

        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    local silent = true
                    local immediate = true
                    card:set_seal(conf.extra.seal, silent, immediate)
                end
                
                return true
            end
        }))
    end,
}