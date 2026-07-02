local mod = SMODS.current_mod
local config = mod.config

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.1 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cm" },
                        nodes = {
                            create_toggle({
                                label = localize('config_mahrlatr_cards_only'),
                                ref_table = config,
                                ref_value = 'mahrlatr_cards_only'
                            })
                        }
                    }
                }
            }
        }
    }
end