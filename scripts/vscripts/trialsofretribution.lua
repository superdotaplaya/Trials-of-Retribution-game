-- This is the primary trialsofretribution trialsofretribution script and should be used to assist in initializing your game mode
TRIALSOFRETRIBUTION_VERSION = "1.00"

-- Set this to true if you want to see a complete debug output of all events/processes done by trialsofretribution
-- You can also change the cvar 'trialsofretribution_spew' at any time to 1 or 0 for output/no output
TRIALSOFRETRIBUTION_DEBUG_SPEW = false 

if Trialsofretribution == nil then
    DebugPrint( '[TRIALSOFRETRIBUTION] creating trialsofretribution game mode' )
    _G.Trialsofretribution = class({})
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
require('libraries/projectiles')
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')
-- This library can be used for performing "Frankenstein" attachments on units
require('libraries/attachments')
-- This library can be used to synchronize client-server data via player/client-specific nettables
require('libraries/playertables')
-- This library can be used to create container inventories or container shops
require('libraries/containers')
-- This library provides a searchable, automatically updating lua API in the tools-mode via "modmaker_api" console command
require('libraries/modmaker')
-- This library provides an automatic graph construction of path_corner entities within the map
require('libraries/pathgraph')
-- This library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')

-- These internal libraries set up trialsofretribution's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/trialsofretribution')
require('internal/events')

-- settings.lua is where you can specify many different properties for your game mode and is one of the core trialsofretribution files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core trialsofretribution files.
require('events')


-- This is a detailed example of many of the containers.lua possibilities, but only activates if you use the provided "playground" map
if GetMapName() == "playground" then
  require("examples/playground")
end

--require("examples/worldpanelsExample")

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function Trialsofretribution:PostLoadPrecache()
  DebugPrint("[TRIALSOFRETRIBUTION] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitTrialsofretribution() but needs to be done before everyone loads in.
]]
function Trialsofretribution:OnFirstPlayerLoaded()
  DebugPrint("[TRIALSOFRETRIBUTION] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function Trialsofretribution:OnAllPlayersLoaded()
  DebugPrint("[TRIALSOFRETRIBUTION] All Players have loaded into the game")
  EmitAnnouncerSound("announcer_announcer_now_select")
end

--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function Trialsofretribution:OnHeroInGame(hero)
  DebugPrint("[TRIALSOFRETRIBUTION] Hero spawned in game for first time -- " .. hero:GetUnitName())

  -- This line for example will set the starting gold of every hero to 500 unreliable gold
  --hero:SetGold(500, false)

  -- These lines will create an item and add it to the player, effectively ensuring they start with the item
  local item = CreateItem("item_example_item", hero, hero)
  hero:AddItem(item)

  --[[ --These lines if uncommented will replace the W ability of any hero that loads into the game
    --with the "example_ability" ability

  local abil = hero:GetAbilityByIndex(1)
  hero:RemoveAbility(abil:GetAbilityName())
  hero:AddAbility("example_ability")]]
end

--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function Trialsofretribution:OnGameInProgress()
  CUSTOM_TEAM_PLAYER_COUNT[DOTA_TEAM_CUSTOM_5] = 15
    local repeat_interval = 30 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 0 -- Start this timer *start_after* game-time seconds later
    print ("Timer is running")
	EmitAnnouncerSound("announcer_announcer_welcome_07")
    Timers:CreateTimer(start_after, function()
        SpawnCreeps()
        return repeat_interval
    end)


function SpawnCreeps()

    
    
--RADIANT MID CREEPS
    local point = Entities:FindByName( nil, "radiantmid"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "radiantmidloc1")
    local unit = CreateUnitByName("npc_dota_creep_custom3_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
      
        
--RADIANT TOP CREEPS
    
    
    
    local point = Entities:FindByName( nil, "radiantbot"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "radiantbotloc1")
    local unit = CreateUnitByName("npc_dota_creep_custom3_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    
    
--RADIANT BOTTOM CREEPS
    

    local point = Entities:FindByName( nil, "radianttop"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "radianttoploc1")
    local unit = CreateUnitByName("npc_dota_creep_custom3_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom3_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
		end

    local repeat_interval = 30 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 0 -- Start this timer *start_after* game-time seconds later
    print ("Timer 2 is running")

    Timers:CreateTimer(start_after, function()
        SpawnCreepsaltiar()
        return repeat_interval
    end)


function SpawnCreepsaltiar()
    
--ALTIAR MID CREEPS
    
        local point = Entities:FindByName( nil, "altiarmid"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "snowmidcreep")
    local unit = CreateUnitByName("npc_dota_creep_custom2_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    

    
-- ALTIAR BOT CREEPS
    
    local point = Entities:FindByName( nil, "altiarbot"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "altiarbotloc1")
    local unit = CreateUnitByName("npc_dota_creep_custom2_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    
-- ALTIAR TOP CREEPS
    
    local point = Entities:FindByName( nil, "altiartop"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "altiartoploc1")
    local unit = CreateUnitByName("npc_dota_creep_custom2_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom2_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
		end

    local repeat_interval = 30 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 0 -- Start this timer *start_after* game-time seconds later
    print ("Timer 2 is running")

    Timers:CreateTimer(start_after, function()
        SpawnCreepsdire()
        return repeat_interval
    end)


function SpawnCreepsdire()
    
-- DIRE MID CREEPS
    
    local point = Entities:FindByName( nil, "diremid"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "diremidloc1")
    local unit = CreateUnitByName("npc_dota_creep_custom4_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    
    
    
    
    -- DIRE TOP CREEPS
    
    local point = Entities:FindByName( nil, "diretop"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "diretoploc1")
    local unit = CreateUnitByName("npc_dota_creep_custom4_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    
    
    -- DIRE BOTTOM CREEPS
    
    local point = Entities:FindByName( nil, "direbot"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "direbotloc1")
    local unit = CreateUnitByName("npc_dota_creep_custom4_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom4_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
	end

    local repeat_interval = 30 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 0 -- Start this timer *start_after* game-time seconds later
    print ("Timer 2 is running")

    Timers:CreateTimer(start_after, function()
        SpawnCreepstempest()
        return repeat_interval
    end)


function SpawnCreepstempest()
    
-- TEMPEST MID CREEPS
    
    local point = Entities:FindByName( nil, "tempestmid"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "tempestmidloc1")
    local unit = CreateUnitByName("npc_dota_creep_custom1_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    

    
    -- TEMPEST BOTTOM CREEPS
    
    local point = Entities:FindByName( nil, "tempestbot"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "tempestbotloc1")
    local unit = CreateUnitByName("npc_dota_creep_custom1_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    
    -- TEMPEST TOP CREEPS
    
    local point = Entities:FindByName( nil, "tempesttop"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "tempesttoploc1")
    local unit = CreateUnitByName("npc_dota_creep_custom1_ranged", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
	    local unit = CreateUnitByName("npc_dota_creep_custom1_melee", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
    print ("units were spawned in!")
    
end

    local repeat_interval = 210 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 210 -- Start this timer *start_after* game-time seconds later
    print ("Timer 2 is running")

    Timers:CreateTimer(start_after, function()
        SpawnCreepssiege()
        return repeat_interval
    end)


function SpawnCreepssiege()

		-- SIEGE CREEPS TEMPEST
		
    local point = Entities:FindByName( nil, "tempesttop"):GetAbsOrigin()
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    local waypoint = Entities:FindByName(nil, "tempesttoploc1")    	
    unit:SetInitialGoalEntity( waypoint )
	print ("siege spawned in")
	local point = Entities:FindByName( nil, "tempestbot"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "tempestbotloc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )

	    local point = Entities:FindByName( nil, "tempestmid"):GetAbsOrigin()

    local waypoint = Entities:FindByName(nil, "tempestmidloc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_2)
    unit:SetInitialGoalEntity( waypoint )
	end
	
	    local repeat_interval = 210 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 210 -- Start this timer *start_after* game-time seconds later
    print ("Timer 2 is running")

    Timers:CreateTimer(start_after, function()
        SpawnCreepssiegedire()
        return repeat_interval
    end)


function SpawnCreepssiegedire()
	
	-- SIEGE CREEPS DIRE
	
	local point = Entities:FindByName( nil, "direbot"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "direbotloc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
	local point = Entities:FindByName( nil, "diretop"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "diretoploc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )
	local point = Entities:FindByName( nil, "diremid"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "diremidloc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_4)
    unit:SetInitialGoalEntity( waypoint )

		end
	
	    local repeat_interval = 210 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 210 -- Start this timer *start_after* game-time seconds later
    print ("Timer 2 is running")

    Timers:CreateTimer(start_after, function()
        SpawnCreepssiegeradiant()
        return repeat_interval
    end)


function SpawnCreepssiegeradiant()
	
	-- SIEGE CREEPS RADIANT
	
	local point = Entities:FindByName( nil, "radianttop"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "radianttoploc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
	local point = Entities:FindByName( nil, "radiantbot"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "radiantbotloc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )

	    local point = Entities:FindByName( nil, "radiantmid"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "radiantmidloc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_3)
    unit:SetInitialGoalEntity( waypoint )
	
	end
	
	    local repeat_interval = 210 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 210 -- Start this timer *start_after* game-time seconds later
    print ("Timer 2 is running")

    Timers:CreateTimer(start_after, function()
        SpawnCreepssiegealtiar()
        return repeat_interval
    end)


function SpawnCreepssiegealtiar()
	
	-- SIEGE CREEPS ALTIAR
	
	local point = Entities:FindByName( nil, "altiartop"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "altiartoploc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
	local point = Entities:FindByName( nil, "altiarbot"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "altiarbotloc1")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )

	local point = Entities:FindByName( nil, "altiarmid"):GetAbsOrigin()
    local waypoint = Entities:FindByName(nil, "snowmidcreep")
    local unit = CreateUnitByName("npc_dota_custom1_siege", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
    unit:SetInitialGoalEntity( waypoint )
end




-- JUNGLE CAMP FUNCTIONS
    local start_after = 0 -- Start this timer *start_after* game-time seconds later
    local repeat_interval = 60
    print ("Timer 2 is running")
    Timers:CreateTimer(start_after, function()
        junglecamps()
        
    end)

function junglecamps()



if _G.canspawn == true then
  local point = Entities:FindByName( nil, "jungleradiante1"):GetAbsOrigin()
  local unit = CreateUnitByName("npc_dota_neutral_kobold", point, true, nil, nil, DOTA_TEAM_CUSTOM_1)
  print("jungle has spawned")
end

-- testing

end



-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function Trialsofretribution:InitTrialsofretribution()
  Trialsofretribution = self
  DebugPrint('[TRIALSOFRETRIBUTION] Starting to load Trialsofretribution trialsofretribution...')

  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  Convars:RegisterCommand( "command_example", Dynamic_Wrap(Trialsofretribution, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )

  DebugPrint('[TRIALSOFRETRIBUTION] Done loading Trialsofretribution trialsofretribution!\n\n')
end

-- This is an example console command
function Trialsofretribution:ExampleConsoleCommand()
  print( '******* Example Console Command ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
      PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
    end
  end

  print( '*********************************************' )
end
