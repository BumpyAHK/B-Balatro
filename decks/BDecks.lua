SMODS.Atlas({
	key = "deckatlas",
	path = "DeckAtlas.png",
	px = 71,
	py = 95,
})

SMODS.Back{ -- Made by Bumpy
    name = "Geology Deck",
    key = "geology",
    pos = {x = 5, y = 0},
    config = {},
    loc_txt = {
        name = "Geology Deck",
        text ={
            "Full of {C:attention,T:m_stone}Stone{} cards"
        },
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_ability(G.P_CENTERS.m_stone)
                end
                return true
            end
        }))
    end
}

SMODS.Back{ -- Made by Bumpy
    name = "King Midas's Deck",
    key = "kingmidasdeck",
    pos = {x = 6, y = 0},
    config = {dollars = 0, no_interest = true, extra_hand_bonus = 0},
    loc_txt = {
        name = "King Midas's Deck",
        text ={
            "Start with {C:money}$0{}",
			"Earn no {C:money}Interest{}",
			"No {C:money}Rewards{}",
            "Full of {C:gold,T:m_gold}Gold Cards{}",
        },
    },
    apply = function()

        G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
        G.GAME.modifiers.no_blind_reward.Small = true
        G.GAME.modifiers.no_blind_reward.Big = true
        G.GAME.modifiers.no_blind_reward.Boss = true
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    G.playing_cards[i]:set_ability(G.P_CENTERS.m_gold)
                end
                return true
            end
        }))
    end
}

SMODS.Back{ -- Made by Facade
    name = "Facade's Deck",
    key = "facadedeck",
    pos = {x = 5, y = 1},
    config = {rank = 'Ace'},
    loc_txt = {
        name = "Facade's Deck",
        text = {
            "Every card is an ace of it's own suit.",
            " Every {C:hearts}Hearts{} and {C:diamonds}Diamonds{} are {C:dark_edition,T:e_polychrome}Polychrome{}",
            "and have a {C:red}Red Seal{}. Every {C:clubs}Clubs{} and ",
            "{C:spades}Spades{} are {C:dark_edition,T:e_foil}Foil{} and have a {C:attention}Gold Seal{}.",
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for it, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, self.config.rank))
                    if card.base.suit == 'Hearts' or card.base.suit == 'Diamonds' then
                        G.playing_cards[it]:set_edition({polychrome = true}, true, true)
                        G.playing_cards[it]:set_seal('Red', true, true)
                    end
                    if card.base.suit == 'Clubs' or card.base.suit == 'Spades' then
                        G.playing_cards[it]:set_edition({foil = true}, true, true)
                        G.playing_cards[it]:set_seal('Gold', true, true)
                    end
                end
                return true
            end
        }))
    end
}

SMODS.Back{ -- Made by Facade
    name = "Facade's Abomination",
    key = "facadesabomination",
    pos = {x = 2, y = 1},
    config = {},
    loc_txt = {
        name = "Facade's Abomination",
        text = {"I'm sorry. {c:dark_edition}:smile:{}"}
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for it, card in ipairs(G.playing_cards) do
                    G.playing_cards[it]:set_edition({negative = true}, true, true)
                end

            for j = 0, 2, 1 do
                for i = 1, #G.playing_cards do
                    local card = G.playing_cards[i]
                    local _card = copy_card(card, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                end
            end

                
                return true
            end
        }))
    end
}

SMODS.Back{ -- Made by Facade
    name = "Steel King Bonanza",
    key = "steelkingbonanza",
    pos = {x = 6, y = 1},
    config = {rank = 'King', vouchers = {'v_observatory', 'v_telescope'}, consumables = {'c_pluto'}},
    loc_txt = {
        name = "Steel King Bonanza",
        text = {"All cards are Kings", 
        "All cards have a {C:red}Red Seal{}",  
        "All cards are {X:mult,C:white}Steel{}",
        "Starts with {C:tarot,T:v_observatory}Observatory{},",
        "{C:tarot,T:v_telescope}Telescope{}, {C:red,E:2}Baron{}, and {C:legendary,E:2}Perkeo{}"}
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local baron_card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_baron', 'deck')
                local perkeo_card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_perkeo', 'deck')
                baron_card:add_to_deck()
                perkeo_card:add_to_deck()
                G.jokers:emplace(baron_card)
                G.jokers:emplace(perkeo_card)
                baron_card:start_materialize()
                perkeo_card:start_materialize()
                for it, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, self.config.rank))
                    G.playing_cards[it]:set_ability(G.P_CENTERS.m_steel)
                    G.playing_cards[it]:set_seal('Red', true, true)
                end
                return true
            end
        }))
    end
}

SMODS.Back{ -- Made by Facade
    name = "Steel King Plasma Bonanza",
    key = "steelkingplasmabonanza",
    pos = {x = 6, y = 1},
    config = {rank = 'King', vouchers = {'v_observatory', 'v_telescope'}, consumables = {'c_pluto'}},
    loc_txt = {
        name = "Steel King Plasma Bonanza",
        text = {"Combines the effects of the Steel",
        "King Bonanza and Plasma Deck.",
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local baron_card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_baron', 'deck')
                local perkeo_card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_perkeo', 'deck')
                baron_card:add_to_deck()
                perkeo_card:add_to_deck()
                G.jokers:emplace(baron_card)
                G.jokers:emplace(perkeo_card)
                baron_card:start_materialize()
                perkeo_card:start_materialize()

                for it, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, self.config.rank))
                    G.playing_cards[it]:set_ability(G.P_CENTERS.m_steel)
                    G.playing_cards[it]:set_seal('Red', true, true)
                end
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        if context.final_scoring_step then
            local tot = hand_chips + mult
            hand_chips = math.floor(tot/2)
            mult = math.floor(tot/2)
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('k_balanced')
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    attention_text({
                        scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  4.3,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                ease_colour(G.C.UI_MULT, G.C.RED, 2)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  6.3,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
    
            delay(0.6)

            return {
                chips = hand_chips,
                mult = mult
            }
        end
    end
}

SMODS.Back{ -- Made by Facade
    name = "Steel King Plasma Negative Bonanza",
    key = "steelkingplasmanegativebonanza",
    pos = {x = 6, y = 1},
    config = {rank = 'King', vouchers = {'v_observatory', 'v_telescope'}, consumables = {'c_pluto'}},
    loc_txt = {
        name = "Steel King Plasma Negative Bonanza",
        text = {"Combines the effects of the Steel",
        "King Bonanza and Plasma Deck.",
        "All Jokers become negative after shop."
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local baron_card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_baron', 'deck')
                local perkeo_card = create_card("Joker", G.jokers, nil, nil, nil, nil, 'j_perkeo', 'deck')
                baron_card:set_edition({negative = true}, true, true)
                perkeo_card:set_edition({negative = true}, true, true)
                baron_card:add_to_deck()
                perkeo_card:add_to_deck()
                G.jokers:emplace(baron_card)
                G.jokers:emplace(perkeo_card)
                baron_card:start_materialize()
                perkeo_card:start_materialize()

                for it, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, self.config.rank))
                    G.playing_cards[it]:set_ability(G.P_CENTERS.m_steel)
                    G.playing_cards[it]:set_seal('Red', true, true)
                end
                return true
            end
        }))
    end,

    calculate = function(self, card, context)
        if context.ending_shop then
            G.E_MANAGER:add_event(Event({
                trigger = 'after', delay = 0.4, func = function()
                    for k, v in pairs(G.jokers.cards) do
                        G.jokers.cards[k]:set_edition({negative = true}, true, true)
                    end
                    return true
                end
            }))
        end

        if context.final_scoring_step then
            local tot = hand_chips + mult
            hand_chips = math.floor(tot/2)
            mult = math.floor(tot/2)
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('k_balanced')
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    attention_text({
                        scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  4.3,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                ease_colour(G.C.UI_MULT, G.C.RED, 2)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  6.3,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
    
            delay(0.6)

            return {
                chips = hand_chips,
                mult = mult
            }
        end
    end
}



SMODS.Back{ -- Made by Bumpy
    name = "Smeared Deck",
    key = "smeareddeck",
	atlas = "deckatlas",
    pos = {x = 0, y = 0},
    config = {discards = 1, 
			dollars = 10, 
			extra_hand_bonus = 2, 
			extra_discard_bonus = 1, 
			no_interest = true, 
			joker_slot = 1,
			consumables = {'c_fool', 'c_fool', 'c_hex'}, 
			consumable_slot = -1, 
			spectral_rate = 2, 
			remove_faces = true, 
			vouchers = {'v_tarot_merchant','v_planet_merchant', 'v_overstock_norm', 'v_crystal_ball', 'v_telescope'}, 
			ante_scaling = 2, 
			randomize_rank_suit = true},
    loc_txt = {
        name = "Smeared Deck",
        text ={
            "Applies Effects of ",
			"ALL vanilla decks"
        },
    },
    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
				for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Clubs' then 
                        v:change_suit('Spades')
                    end
                    if v.base.suit == 'Diamonds' then 
                        v:change_suit('Hearts')
                    end
                end
                return true
            end
        }))
		
    end,
	calculate = function(self, card, context)	
        if context.final_scoring_step then
            local tot = hand_chips + mult
            hand_chips = math.floor(tot/2)
            mult = math.floor(tot/2)
            update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
			
			if G.GAME.last_blind and G.GAME.last_blind.boss then
				G.E_MANAGER:add_event(Event({
						func = (function()
							add_tag(Tag('tag_double'))
							play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
							play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
							return true
						end)
					}))
				end			

            G.E_MANAGER:add_event(Event({
                func = (function()
                    local text = localize('k_balanced')
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    attention_text({
                        scale = 1.4, text = text, hold = 2, align = 'cm', offset = {x = 0,y = -2.7},major = G.play
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  4.3,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                                ease_colour(G.C.UI_MULT, G.C.RED, 2)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  6.3,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
    
            delay(0.6)

            return {
            }
        end
    end
}