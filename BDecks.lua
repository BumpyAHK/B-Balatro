--_RELEASE_MODE = false -- REMOVE FOR RELEASE

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
    name = "Steel Ace Bonanza",
    key = "steelacebonanza",
    pos = {x = 6, y = 1},
    config = {rank = 'Ace'},
    loc_txt = {
        name = "Steel Ace Bonanza",
        text = {"All cards are Aces", 
        "All cards have a {C:red}Red Seal{}",  
        "All cards are {X:mult,C:white}Steel{}",
                "{C:attention}+2{} hand size"}
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand.config.card_limit = G.hand.config.card_limit + 2
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