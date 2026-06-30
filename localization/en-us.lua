return {
    descriptions = {
        Joker = {
            j_mahrlatr_themahr = {
                name = 'The Mahr!?',
                text = {
                    '{C:money}#1##2#{} & {C:red}#2# Mult{} for every hand played'
                }
            },

            j_mahrlatr_thestahr = {
                name = 'The Stahr',
                text = {
                    'Each scored 6 or 7 gives {C:money}#1##2#{}'
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
                    'Gives {X:red,C:white}X0.2{} Mult for every',
                    '{C:attention}Wild card{} currently in {C:gold}Full Hand{}',
                    '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
                }
            },

            j_mahrlatr_thedoctor = {
                name = 'The Doctor',
                text = {
                    'Gains {X:mult,C:white}X#1#{} Mult for each {C:money}#2##3#{} spent',
                    'Halves for every ante',
                    '{C:inactive}(Currently{} {X:mult,C:white}X#3#{} {C:inactive}Mult){}'
                }
            },

            j_mahrlatr_thehahrt = {
                name = 'The Hahrt',
                text = {
                    'Played cards with {C:hearts}Heart{} suit',
                    'give {C:mult}+3{} Mult when scored'
                }
            },

            j_mahrlatr_diamahrnds = {
                name = 'Diamahrnds Are Forever',
                text = {
                    'Played cards with {C:hearts}Diamond{} suit',
                    'give {C:mult}+3{} Mult when scored'
                }
            },

            j_mahrlatr_nutellasweep = {
                name = 'Nutella Sweep',
                text = {
                    'Gives {X:red,C:white}X0.25{} Mult per',
                    'unique {C:planet}Planet{} card used this run',
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
                        "(excluding Normal Guy)"
                    }
                }
            },

            j_mahrlatr_bankofamahrica = {
                name = 'Bank Of Amahrica',
                text = {
                    'Go up to {C:red}-#1##2#{} in debt'
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
                    'card for {C:gold}#1##2#{}'
                }
            },

            j_mahrlatr_mimahr = {
                name = 'Mimahr',
                text = {
                    'Retrigger all cards with a {C:tarot}the mahr{} seal'
                }
            },

            j_mahrlatr_supahrnutellio = {
                name = 'Supahr Nutellio',
                text = {
                    'Gives {C:blue}#1# chips{} for each played',
                    'hand and for each stahr joker',
                    '{C:inactive}Currently:{} {C:blue}#2#{} {C:inactive}Chips{}'
                }
            },

            j_mahrlatr_meat = {
                name = 'Meat',
                text = {
                    {
                        '{C:red}+#1#{} Mult if hand contains',
                        'scoring {C:red,E:2}red{} suit cards.'
                    },
                    {
                        '{C:inactive}Merges into Mahrbles Trolley{}',
                        '{C:inactive}if you own Mahrffin and Fish{}',
                        '{C:inactive}at the start of a round{}'
                    }
                }
            },

            j_mahrlatr_mahrffin = {
                name = 'Mahr{}ffin',
                text = {
                    {
                        'Gives {C:money}#1##2#{} for each',
                        'played {C:blue}hand'
                    },
                    {
                        '{C:inactive}Merges into Mahrbles Trolley{}',
                        '{C:inactive}if you own Meat and Fish{}',
                        '{C:inactive}at the start of a round{}'
                    }
                }
            },

            j_mahrlatr_fish = {
                name = 'Fish',
                text = {
                    {
                        '{C:blue}+#1#{} Chips if hand contains',
                        'scoring {C:black,E:2}black{} suit cards'
                    },
                    {
                        '{C:inactive}Merges into Mahrbles Trolley{}',
                        '{C:inactive}if you own Meat and Marffin{}',
                        '{C:inactive}at the start of a round{}'
                    }
                }
            },

           j_mahrlatr_splas = {
                name = 'Splas',
                text = {
                    {
                        'Every {C:attention}played card{} counts in scoring'
                    }
                }

            },

            j_mahrlatr_mahrbles_trolley = {
                name = 'Mahrbles Trolley',
                text = {
                    '{C:red}+#1#{} Mult, {C:blue}+#2#{} Chips',
                    'and {C:money}#3##4#{} for each',
                    'played {C:blue}hand'
                }
            },

            j_mahrlatr_kahrlmahrx = {
                name = 'Kahrl Mahrx',
                text = {
                    'Equalizes {C:blue}Chips{} and {C:red}Mult{}'
                }
            },

            j_mahrlatr_scarycrimson = {
                name = '{C:red}Scary Crimson{}',
                text = {
                    'Gains {X:mult,C:white}X#2#{} for each',
                    '{E:1}black suit card{} in the deck',
                    'Converts {C:attention}all scored cards{}',
                    'into a random {C:red,E:1}red suit card{}',
                    '{C:inactive}Currently:{} {X:mult,C:white}X#1#{}'
                }
            }
        },

        Tarot = {
            c_mahrlatr_mahrmentioned = {
                name = 'Mahr Mentioned',
                text = {
                    'Applies {C:tarot,E:1}TheMahr{} seal to selected card'
                }
            }
        },

        Other = {
            mahrlatr_mahr_seal = {
                name = 'Mahr Seal',
                label = 'Mahr Seal',
                text = {
                    'Gives {C:red}#1# mult{} for every {E:1}Mahr{} Jokahr'
                }
            }
        },
    },

    misc = {
        dictionary = {
            doctor_halved = 'Halved!',
            doctor_back_to_1x = 'Back where it began!',
            nutellio_easy = 'EZ!',
            crimson_spreads = 'The Crimson spreads...',
            mahrfiamember_card_destroyed = 'Pleasure Doing Business',
            lehospital_medical_debt = 'Medical Debt',
            lehospital_saved = 'Le Hospital Saved You..',
            lehospital_destroyed = 'Destroyed!'
        }
    }
}