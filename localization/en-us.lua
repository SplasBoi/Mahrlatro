return {
    descriptions = {
        Joker = {
            j_mahrlatr_themahr = {
                name = 'The Mahr!?',
                text = {
                    '{C:money}$#1#{} & {C:red}#2# Mult{} for every hand played'
                }
            },

            j_mahrlatr_thestahr = {
                name = 'The Stahr',
                text = {
                    'Each scored 6 or 7 gives {C:money}$#1#{}'
                }
            },

            j_mahrlatr_weemahr = {
                name = 'Wee Mahr',
                text = {
                    'This Jokahr gains {C:blue}+8{} Chips',
                    'when each played {C:attention}2{} is scored',
                    '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
                }
            },

            j_mahrlatr_wildcat = {
                name = 'Wild Cat',
                text = {
                    'Gives {X:red,C:white}X0.2{} Mult for',
                    'every {C:attention}Wild card{} currently in {C:gold}Full Hand{}.',
                    '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
                }
            },

            j_mahrlatr_thedoctor = {
                name = 'The Doctor',
                text = {
                    {
                        'Gains {X:mult,C:white}X#1#{} Mult for each {C:money}$#2#{} spent.',
                        'XMult is halved at the end of the round.',
                    },
                    {
                        'Currently {X:mult,C:white}X#3#',
                        '{C:inactive}To next upgrade:{} {C:money}$#4#{}/{C:money}$20{}'
                    }
                }
            },

            j_mahrlatr_thehahrt = {
                name = 'The Hahrt',
                text = {
                    'Played cards with {C:hearts}Heart{} suit',
                    'give {C:mult}+3{} Mult when scored'
                }
            },

            j_mahrlatr_nutellasweep = {
                name = 'Nutella Sweep',
                text = {
                    'Gives {X:red,C:white}X0.25{} Mult per ',
                    'unique {C:planet}Planet{} card used this run.',
                    '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
                }
            },

            j_mahrlatr_epicweed = {
                name = 'Epic Weed',
                text = {
                    'Played cards with {C:uncommon}Club{} suit ',
                    'give {C:mult}+3{} Mult when scored'
                }
            },

            j_mahrlatr_normalguy = {
                name = 'Normal Guy',
                text = {
                    {
                        'Sets:',
                        '{C:blue}Hands{} to {C:blue}#1#{}',
                        '{C:red}Discards{} to {C:red}#2#{}',
                        '{V:1}Joker Slots{} to {V:1}#3#{}',
                        '{C:purple}Consumable Slots{} to {C:purple}#4#{}'
                    },
                    {
                        'Destroys overflowing',
                        'jokers/consumables',
                        'from right to left',
                        "(excluding Normal Guy)."
                    }
                }
            },

            j_mahrlatr_bankofamahrica = {
                name = 'Bank Of Amahrica',
                text = {
                    'Go up to {C:red}-$#1#{} in debt'
                }
            },

            j_mahrlatr_lehospital = {
                name = 'Le Hospital',
                text = {
                    'Prevents death at a cost...'
                }
            },

            j_mahrlatr_mahrfiamember = {
                name = 'Mahrfia Member',
                text = {
                    'Destroys every played {C:red}Heart{}',
                    'card for {C:gold}#1# Dollahrs{}'
                }
            },

            j_mahrlatr_mimahr = {
                name = 'Mimahr',
                text = {
                    'Retrigger all card {C:orange}held in hand{} abilities'
                }
            },

            j_mahrlatr_supahrnutellio = {
                name = 'Supahr Nutellio',
                text = {
                    {
                        '{C:blue}+67{} Chips'
                    },
                    {
                        'Adds +{C:blue}67{} Chips for each',
                        '{C:attention}Stahr{} jokahr held.'
                    }
                }
            },

            j_mahrlatr_meat = {
                name = 'Meat',
                text = {
                    {
                        '{C:red}+7{} Mult if hand contains',
                        'scoring {C:red,E:2}red{} suit cards.'
                    }
                }
            },

            j_mahrlatr_mahrffin = {
                name = 'Mahr{}ffin',
                text = {
                    {
                        'Gives {C:money}$1{} for each',
                        'played {C:blue}hand.'
                    }
                }
            }
        },

        Tarot = {
            c_mahrlatr_mahrmentioned = {
                name = 'Mahr Mentioned',
                text = {
                    'Applies {C:tarot,E:1}TheMahr{} seal to selected card.'
                }
            }
        },

        Other = {
            mahrlatr_mahrseal_seal = {
                name = 'Mahr Seal',
                label = 'Mahr Seal',
                text = {
                    'Gives {C:red}#1# mult{} for every {E:1}Mahr{} Jokahr'
                }
            }
        },
    }
}