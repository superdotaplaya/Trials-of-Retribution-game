--- This file contains all trialsofretribution-registered events and has already set up the passed-in parameters for your use.

-- Cleanup a player when they leave
function Trialsofretribution:OnDisconnect(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] Player Disconnected ' .. tostring(keys.userid))
  DebugPrintTable(keys)

  local name = keys.name
  local networkid = keys.networkid
  local reason = keys.reason
  local userid = keys.userid

end
-- The overall game state has changed
function Trialsofretribution:OnGameRulesStateChange(keys)
  DebugPrint("[TRIALSOFRETRIBUTION] GameRules State Changed")
  DebugPrintTable(keys)

  local newState = GameRules:State_Get()
end

-- An NPC has spawned somewhere in game.  This includes heroes
function Trialsofretribution:OnNPCSpawned(keys)
  DebugPrint("[TRIALSOFRETRIBUTION] NPC Spawned")
  DebugPrintTable(keys)

  local npc = EntIndexToHScript(keys.entindex)
end

-- An entity somewhere has been hurt.  This event fires very often with many units so don't do too many expensive
-- operations here
function Trialsofretribution:OnEntityHurt(keys)
  --DebugPrint("[TRIALSOFRETRIBUTION] Entity Hurt")
  --DebugPrintTable(keys)

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless
  if keys.entindex_attacker ~= nil and keys.entindex_killed ~= nil then
    local entCause = EntIndexToHScript(keys.entindex_attacker)
    local entVictim = EntIndexToHScript(keys.entindex_killed)

    -- The ability/item used to damage, or nil if not damaged by an item/ability
    local damagingAbility = nil

    if keys.entindex_inflictor ~= nil then
      damagingAbility = EntIndexToHScript( keys.entindex_inflictor )
    end
  end
end

-- An item was picked up off the ground
function Trialsofretribution:OnItemPickedUp(keys)
  DebugPrint( '[TRIALSOFRETRIBUTION] OnItemPickedUp' )
  DebugPrintTable(keys)

  local unitEntity = nil
  if keys.UnitEntitIndex then
    unitEntity = EntIndexToHScript(keys.UnitEntitIndex)
  elseif keys.HeroEntityIndex then
    unitEntity = EntIndexToHScript(keys.HeroEntityIndex)
  end

  local itemEntity = EntIndexToHScript(keys.ItemEntityIndex)
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local itemname = keys.itemname
end

-- A player has reconnected to the game.  This function can be used to repaint Player-based particles or change
-- state as necessary
function Trialsofretribution:OnPlayerReconnect(keys)
  DebugPrint( '[TRIALSOFRETRIBUTION] OnPlayerReconnect' )
  DebugPrintTable(keys) 
end

-- An item was purchased by a player
function Trialsofretribution:OnItemPurchased( keys )
  DebugPrint( '[TRIALSOFRETRIBUTION] OnItemPurchased' )
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
  
end

-- An ability was used by a player
function Trialsofretribution:OnAbilityUsed(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] AbilityUsed')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityname = keys.abilityname
end

-- A non-player entity (necro-book, chen creep, etc) used an ability
function Trialsofretribution:OnNonPlayerUsedAbility(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnNonPlayerUsedAbility')
  DebugPrintTable(keys)

  local abilityname=  keys.abilityname
end

-- A player changed their name
function Trialsofretribution:OnPlayerChangedName(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnPlayerChangedName')
  DebugPrintTable(keys)

  local newName = keys.newname
  local oldName = keys.oldName
end

-- A player leveled up an ability
function Trialsofretribution:OnPlayerLearnedAbility( keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnPlayerLearnedAbility')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local abilityname = keys.abilityname
end

-- A channelled ability finished by either completing or being interrupted
function Trialsofretribution:OnAbilityChannelFinished(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnAbilityChannelFinished')
  DebugPrintTable(keys)

  local abilityname = keys.abilityname
  local interrupted = keys.interrupted == 1
end

-- A player leveled up
function Trialsofretribution:OnPlayerLevelUp(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnPlayerLevelUp')
  DebugPrintTable(keys)

  local player = EntIndexToHScript(keys.player)
  local level = keys.level
end

-- A player last hit a creep, a tower, or a hero
function Trialsofretribution:OnLastHit(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnLastHit')
  DebugPrintTable(keys)

  local isFirstBlood = keys.FirstBlood == 1
  if(isFirstBlood)then EmitAnnouncerSound ("announcer_killing_spree_announcer_1stblood_01")end
  local isHeroKill = keys.HeroKill == 1
  local isTowerKill = keys.TowerKill == 1
  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local killedEnt = EntIndexToHScript(keys.EntKilled)
end

-- A tree was cut down by tango, quelling blade, etc
function Trialsofretribution:OnTreeCut(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnTreeCut')
  DebugPrintTable(keys)

  local treeX = keys.tree_x
  local treeY = keys.tree_y
end

-- A rune was activated by a player
function Trialsofretribution:OnRuneActivated (keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnRuneActivated')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local rune = keys.rune

  --[[ Rune Can be one of the following types
  DOTA_RUNE_DOUBLEDAMAGE
  DOTA_RUNE_HASTE
  DOTA_RUNE_HAUNTED
  DOTA_RUNE_ILLUSION
  DOTA_RUNE_INVISIBILITY
  DOTA_RUNE_BOUNTY
  DOTA_RUNE_MYSTERY
  DOTA_RUNE_RAPIER
  DOTA_RUNE_REGENERATION
  DOTA_RUNE_SPOOKY
  DOTA_RUNE_TURBO
  ]]
end

-- A player took damage from a tower
function Trialsofretribution:OnPlayerTakeTowerDamage(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnPlayerTakeTowerDamage')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local damage = keys.damage
end

-- A player picked a hero
function Trialsofretribution:OnPlayerPickHero(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnPlayerPickHero')
  DebugPrintTable(keys)

  local heroClass = keys.hero
  local heroEntity = EntIndexToHScript(keys.heroindex)
  local player = EntIndexToHScript(keys.player)
end

-- A player killed another player in a multi-team context
function Trialsofretribution:OnTeamKillCredit(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnTeamKillCredit')
  DebugPrintTable(keys)

  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local victimPlayer = PlayerResource:GetPlayer(keys.victim_userid)
  local numKills = keys.herokills
  local killerTeamNumber = keys.teamnumber
end


-- An entity died
function Trialsofretribution:_OnEntityKilled( keys )
  DebugPrint( '[TRIALSOFRETRIBUTION] OnEntityKilled Called' )
  DebugPrintTable( keys )

  -- The Unit that was Killed
      local killedUnit = EntIndexToHScript( keys.entindex_killed )
          local killer = EntIndexToHScript( keys.entindex_attacker )
          local unit_killed = killedUnit:GetName()
          if(unit_killed == "npc_dota_roshan") then 
          	 Trialsofretribution:OnRoshanKilled ( keys )
          	end

       local killedUnit = EntIndexToHScript( keys.entindex_killed )
          local killer = EntIndexToHScript( keys.entindex_attacker )
          local unit_killed = killedUnit:GetName()
          if(unit_killed == "npc_dota_courier") then 
          	 Trialsofretribution:OnCourierKilled ( keys )
          	end


  -- The Killing entity
  local killerEntity = nil

  if keys.entindex_attacker ~= nil then
    killerEntity = EntIndexToHScript( keys.entindex_attacker )
  end

  -- The ability/item used to kill, or nil if not killed by an item/ability
  local killerAbility = nil

  if keys.entindex_inflictor ~= nil then
    killerAbility = EntIndexToHScript( keys.entindex_inflictor )
  end

  local damagebits = keys.damagebits -- This might always be 0 and therefore useless
  if killedUnit:IsFort() then
    --TODO: Uncomment this when bugfixing OnFortKilled
    Trialsofretribution:OnFortKilled( keys )
  end
  
  if killedUnit:IsBuilding() then
	  Trialsofretribution:OnCustomTowerKilled( keys )
	else
  end

  if killedUnit:IsCreature() then
  	Trialsofretribution:OnCreatureKilled( keys )
  else
  end
end

function Trialsofretribution:OnCourierKilled ( keys )
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	local killedTeam = killedUnit:GetTeamNumber()
	print(killedUnit:GetTeamNumber())
		if(killedTeam == 6) then EmitAnnouncerSound("announcer_ann_custom_courier_slain_02")end
		if(killedTeam == 7) then EmitAnnouncerSound("announcer_ann_custom_courier_slain_11")end
		if(killedTeam == 8) then EmitAnnouncerSound("announcer_ann_custom_courier_slain_01")end
		if(killedTeam == 9) then EmitAnnouncerSound("announcer_ann_custom_courier_slain_03")end 
		if(killedTeam == 2) then EmitAnnouncerSound("announcer_ann_custom_courier_slain_03")end
end

function Trialsofretribution:OnRoshanKilled ( keys )
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	local killer = EntIndexToHScript( keys.entindex_attacker )
	local killing_team = killer:GetTeamNumber()
	if(killing_team == 6) then EmitAnnouncerSound("announcer_ann_custom_roshan_fall_02")end
	if(killing_team == 7) then EmitAnnouncerSound("announcer_ann_custom_roshan_fall_11")end
	if(killing_team == 8) then EmitAnnouncerSound("announcer_ann_custom_roshan_fall_01")end
	if(killing_team == 9) then EmitAnnouncerSound("announcer_ann_custom_roshan_fall_03")end
end

function Trialsofretribution:OnCreatureKilled( keys )
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	local creature_name = killedUnit:GetName()
	print(killedUnit:GetName())
		if(creature_name == "npc_dota_creature") then EmitAnnouncerSound("announcer_announcer_beast_slain_01")
	print("unit is norva")
else
	end
end


function Trialsofretribution:OnCustomTowerKilled( keys )
    local killer = EntIndexToHScript( keys.entindex_attacker )
    local killedUnit = EntIndexToHScript( keys.entindex_killed )
   
    --For reference, the teams are mapped as follows
    --Team 6 = Tempest
    --Team 7  = Altair
    --Team 8 = Radiant
    --Team 9 = Dire
   
    local tower_name = killedUnit:GetName()
    --Make sure what we're looking at has a name
    if tower_name == nil then
        return
    end
   
    if(tower_name == "radiantbot1" or tower_name == "radiantbot2" or tower_name == "radiantbot3" or tower_name == "radiantmid1" or tower_name == "radiantmid2" or tower_name == "radiantmid3" or tower_name == "radianttop1" or tower_name == "radianttop2" or tower_name == "radianttop3" or tower_name == "radianttop4" or tower_name == "radiantbot4") then
EmitAnnouncerSound("announcer_ann_custom_tower_fall_01") end
    if(tower_name == "direbot1" or tower_name == "direbot2" or tower_name == "direbot3" or tower_name == "diremid1" or tower_name == "diremid2" or tower_name == "diremid3" or tower_name == "diretop1" or tower_name == "diretop2" or tower_name == "diretop3" or tower_name == "diretop4" or tower_name == "direbot4") then
EmitAnnouncerSound("announcer_ann_custom_tower_fall_03")end
	if(tower_name == "tempestbot1" or tower_name == "temestbot2" or tower_name == "tempestbot3" or tower_name == "tempestmid1" or tower_name == "tempestmid2" or tower_name == "tempestmid3" or tower_name == "tempesttop1" or tower_name == "tempesttop2" or tower_name == "tempesttop3" or tower_name == "tempesttop4" or tower_name == "tempestbot4") then
EmitAnnouncerSound("announcer_ann_custom_tower_fall_02")end
	if(tower_name == "altiarbot1" or tower_name == "altiarbot2" or tower_name == "altiarbot3" or tower_name == "altiarmid1" or tower_name == "altiarmid2" or tower_name == "altiarmid3" or tower_name == "altiartop1" or tower_name == "altiartop2" or tower_name == "altiartop3" or tower_name == "altiartop4" or tower_name == "altiarbot4") then
EmitAnnouncerSound("announcer_ann_custom_tower_fall_11")end
 
    local tower_num = tonumber(tower_name:sub(string.len(tower_name),string.len(tower_name)))
   
    --Make sure what we're looking at is a tower.
    --Only towers will be a npc_dota_building with a name ending in a number
    if not tower_num then
        return
    end
	
	local tower_num = tonumber(tower_name:sub(string.len(tower_name),string.len(tower_name)))
	
	--Make sure what we're looking at is a tower. 
	--Only towers will be a npc_dota_building with a name ending in a number
	if not tower_num then
		return
	end
	
	local tower_gold = 120 + tower_num * 40 -- The tower gold is 120 base gold + 40 x the tower tier (ex: Tier 1 = 160, Tier 2 = 200)
	local deny_gold = tower_gold * 0.16
	
	--Check to see if the tower was denied
	if killer:GetTeam() == killedUnit:GetTeam() then
		--Loop through each of the four teams
		for i=6,9,1 do
			--Confirm that team getting gold is not the tower owner's team
			if i~=killer:GetTeam() then
				--Give 1/6th of the normal tower gold to each player on that team
				for j=1,5,1 do
					local current_player = PlayerResource:GetNthPlayerIDOnTeam(i, j)
					if current_player ~= nil then
						PlayerResource:ModifyGold(current_player,deny_gold, true, DOTA_ModifyGold_Building)
					end
				end
			end
		end
	else
		--Give each player from the killing team the tower_gold
		for i=1,5,1 do
			local current_player = PlayerResource:GetNthPlayerIDOnTeam(killer:GetTeam(), i)
			if current_player ~= nil then
				PlayerResource:ModifyGold(current_player,tower_gold, true, DOTA_ModifyGold_Building)
			end
		end
	end
end

function Trialsofretribution:OnFortKilled( keys )
  local killedUnit = EntIndexToHScript( keys.entindex_killed )
  local killedTeam = killedUnit:GetTeamNumber()

  if(killedTeam == 6) then EmitAnnouncerSound("announcer_ann_custom_defeated_02")end 
  if(killedTeam == 7) then EmitAnnouncerSound("announcer_ann_custom_defeated_011")end 
  if(killedTeam == 8) then EmitAnnouncerSound("announcer_ann_custom_defeated_01")end 
  if(killedTeam == 9) then EmitAnnouncerSound("announcer_ann_custom_defeated_03")end  

  local all_units = Entities:FindAllInSphere(Vector(0,0,0), 12000.0)
  local remainingFort
  local fortCount = 0
  local players = {}

  local teams = {'tempest', 'altiar', 'radiant', 'dire'}
  local lanes = {'top', 'mid', 'bot' }
  local spawners = {}

  for _, value in pairs(lanes) do
    local spawner = teams[killedTeam-5]..value
    print('spawner name is: '..spawner)
    table.insert(spawners, spawner)
  end


  --Destroy all units from team that lost, find all players on that team
  for number,entity in pairs(all_units) do
    print(entity:GetName())
    for _, value in pairs(spawners) do
      if entity:GetName() == value then
        print('REMOVING SPAWNER')
        print(entity:GetName())
        entity:RemoveSelf()
      end
    end

    if entity:GetTeamNumber() == killedTeam then
      --print("number", number, "entity", entity:GetName())
      if entity ~= killedUnit then
        --Record all the players on the killed team
        
        if entity:IsPlayer() then
          local contains = false
          for _, value in pairs(players) do
            if value == entity:GetPlayerID() then
              contains = true
            end
          end
          if contains == false then
            table.insert(players, entity:GetPlayerID())
          end
        else
          print("removing unit..", entity:GetName())
          entity:RemoveSelf()
        end
      end
    end
    if IsValidEntity(entity) and entity ~= killedUnit and isAncient(entity) then
      fortCount = fortCount + 1
      remainingFort = entity
    end
  end
  if fortCount == 1 then
    GameRules:SetGameWinner(remainingFort:GetTeamNumber())
	if(remainingFort:GetTeamNumber() == 6) then EmitAnnouncerSound("announcer_ann_custom_victory_02")end
	if(remainingFort:GetTeamNumber() == 7) then EmitAnnouncerSound("announcer_ann_custom_victory_011")end
	if(remainingFort:GetTeamNumber() == 8) then EmitAnnouncerSound("announcer_ann_custom_victory_01")end
	if(remainingFort:GetTeamNumber() == 9) then EmitAnnouncerSound("announcer_ann_custom_victory_03")end
    GameRules:SetSafeToLeave(true)
    GameRules:Victory()
  end

  --puts all the players on the lost team on custom team 3
  for _, playerID in pairs(players) do
    local player = PlayerResource:GetPlayer(playerID)
    local hero = player:GetAssignedHero()
    if hero:IsAlive() then
      hero:SetRespawnsDisabled(true)
      hero:ForceKill(false)
      else
        heroRespawnUnit()
        hero:SetRespawnsDisabled(true)
        hero:ForceKill(false)

          

        end


    local fow = Entities:FindByName( nil, "mid"):GetAbsOrigin()
    AddFOWViewer(killedTeam, fow, 60000000, 999999999, false)
    local fow = Entities:FindByName( nil, "radiant"):GetAbsOrigin()
    AddFOWViewer(killedTeam, fow, 6000000, 999999999, false)
    local fow = Entities:FindByName( nil, "dire"):GetAbsOrigin()
    AddFOWViewer(killedTeam, fow, 6000000, 999999999, false)
        local fow = Entities:FindByName( nil, "altiar"):GetAbsOrigin()
    AddFOWViewer(killedTeam, fow, 6000000, 999999999, false)
    local fow = Entities:FindByName( nil, "tempest"):GetAbsOrigin()
    AddFOWViewer(killedTeam, fow, 6000000, 999999999, false)



    

  end

  --todo: make custom 3 spectator like

end

function isAncient(entity)
  local name = entity:GetName()
  return name == "tempestancient" or name == "kanikancient" or name == "radiantancient" or name == "direancient"
end


function kill(entity)
  entity:Kill()
end


-- This function is called 1 to 2 times as the player connects initially but before they 
-- have completely connected
function Trialsofretribution:PlayerConnect(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] PlayerConnect')
  DebugPrintTable(keys)
end

-- This function is called once when the player fully connects and becomes "Ready" during Loading
function Trialsofretribution:OnConnectFull(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnConnectFull')
  DebugPrintTable(keys)
  
  local entIndex = keys.index+1
  -- The Player entity of the joining user
  local ply = EntIndexToHScript(entIndex)
  
  -- The Player ID of the joining player
  local playerID = ply:GetPlayerID()
end

-- This function is called whenever illusions are created and tells you which was/is the original entity
function Trialsofretribution:OnIllusionsCreated(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnIllusionsCreated')
  DebugPrintTable(keys)

  local originalEntity = EntIndexToHScript(keys.original_entindex)
end

-- This function is called whenever an item is combined to create a new item
function Trialsofretribution:OnItemCombined(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnItemCombined')
  DebugPrintTable(keys)

  -- The playerID of the hero who is buying something
  local plyID = keys.PlayerID
  if not plyID then return end
  local player = PlayerResource:GetPlayer(plyID)

  -- The name of the item purchased
  local itemName = keys.itemname 
  
  -- The cost of the item purchased
  local itemcost = keys.itemcost
end

-- This function is called whenever an ability begins its PhaseStart phase (but before it is actually cast)
function Trialsofretribution:OnAbilityCastBegins(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnAbilityCastBegins')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.PlayerID)
  local abilityName = keys.abilityname
end

-- This function is called whenever a tower is killed
function Trialsofretribution:OnTowerKill(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnTowerKill')
  DebugPrintTable(keys)

  local gold = keys.gold
  local killerPlayer = PlayerResource:GetPlayer(keys.killer_userid)
  local team = keys.teamnumber
end

-- This function is called whenever a player changes there custom team selection during Game Setup 
function Trialsofretribution:OnPlayerSelectedCustomTeam(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnPlayerSelectedCustomTeam')
  DebugPrintTable(keys)

  local player = PlayerResource:GetPlayer(keys.player_id)
  local success = (keys.success == 1)
  local team = keys.team_id
end

-- This function is called whenever an NPC reaches its goal position/target
function Trialsofretribution:OnNPCGoalReached(keys)
  DebugPrint('[TRIALSOFRETRIBUTION] OnNPCGoalReached')
  DebugPrintTable(keys)

  local goalEntity = EntIndexToHScript(keys.goal_entindex)
  local nextGoalEntity = EntIndexToHScript(keys.next_goal_entindex)
  local npc = EntIndexToHScript(keys.npc_entindex)
end

-- This function is called whenever any player sends a chat message to team or All
function Trialsofretribution:OnPlayerChat(keys)
  local teamonly = keys.teamonly
  local userID = keys.userid
  --TODO: Fix, This line was throwing a null value error so I commented it out for now
  --local playerID = self.vUserIds[userID]:GetPlayerID()

  local text = keys.text
end

function printTable(t)

  function printTableHelper(t, spacing)
    for k,v in pairs(t) do
      print(spacing..tostring(k), v)
      if (type(v) == "table") then
        printTableHelper(v, spacing.."\t")
      end
    end
  end

  printTableHelper(t, "");
end