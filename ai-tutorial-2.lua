
math.randomseed( require("os").time() )
require("ai.ai")
--git test
OSBindex = 1
checkfirstturn = true 

function OnStartOfDuel()	
	AI.Chat("This is a tutorial AI file")
end

function OnSelectOption(options)
	return math.random(#options)
end

function OnSelectEffectYesNo(id, triggeringCard)
	if id == 56120475 then 
		if ChainRArmor() then
			return 1
		else
			return 0
		end
	end
	return 1
end

function ChainRArmor()
	RAlist = {86188410, 81105204, 94977269, 31386180, 44405066,44508094,24696097,83994433,35952884}
	for i=1,#RAlist do
		if Duel.GetAttacker():GetCode() == RAlist[i] then
				return true
		end
	end
	if Duel.GetAttacker():GetCode() == 95600067 and Duel.GetAttackTarget():GetAttack() <= 2000 then
		return false
	end
	if Duel.GetAttacker():GetCode() == 79853073 and Duel.GetAttackTarget():GetAttack() <= 3350 and Duel.GetAttackTarget():GetRace() == 1  then
		return false
	end
	if Duel.GetAttacker():GetCode() == 96235275 and Duel.GetAttackTarget():GetAttack() <= 2100 then
		return false
	end
	if Duel.GetAttacker():GetCode() == 36687247 and Duel.GetAttackTargeT():GetAttack() <= 2000 then
		return false
	end
	if Duel.GetAttacker():GetAttack() >= Duel.GetAttackTarget():GetAttack() then
		return false
	else
		return true
	end
end
	

function OnSelectYesNo(description_id)
	if description_id == 30 then -- continue attacking
		return 1
	else
		return -1
	end
end

function OnSelectPosition(id, available)
	local result = 0
	local band = bit32.band
  	result = POS_FACEUP_ATTACK
	if band(result,available) == 0 then
		if band(POS_FACEUP_ATTACK,available) > 0 then
			result = POS_FACEUP_ATTACK
		elseif band(POS_FACEUP_DEFENCE,available) > 0 then
			result = POS_FACEUP_DEFENCE
		elseif band(POS_FACEDOWN_DEFENCE,available) > 0 then
			result = POS_FACEDOWN_DEFENCE
		else
			result = POS_FACEDOWN_ATTACK
		end
	end
	return result
end

function OnSelectTribute(cards,minTributes, maxTributes)
	local result = {}
	local tributes = {}
	for i=1,#cards do
		tributes[i] = {attack=cards[i].attack, index=i}
	end
	table.sort(tributes, function(a,b) return a.attack<b.attack end)
	for i=1,minTributes do
		result[i]=tributes[i].index
	end
	return result
end

function OnDeclareMonsterType(count, choices)
	local result = 0
	local returnCount = 0
	while returnCount < count do
		result = result + choices[returnCount+1]
		returnCount = returnCount + 1
	end
	return result
end

function OnDeclareAttribute(count, choices)
	local result = 0
	local returnCount = 0
	while returnCount < count do
		result = result + choices[returnCount+1]
		returnCount = returnCount + 1
	end
	return result
end

function OnDeclareCard()	
	return 85138716 -- Rescue Rabbit
end

function OnSelectNumber(choices)
	return math.random(#choices)
end

function OnSelectChain(cards, only_chains_by_player, forced)
	for i=1, #cards do
		local c = cards[i]
		if c.id == 56120475 then
                       if ChainRArmor() then
			   return 0,i
                       else
                           return 1,i
                       end
		end
	end
	return 1,1
end


function OnSelectSum(cards, sum, triggeringCard)
	local result = {}
	local num_levels = 0
	for i=1,#cards do
		num_levels = num_levels + cards[i].level
		result[i]=i
		if(num_levels >= sum) then
			break
		end
	end
	return result
end


function OnSelectBattleCommand(cards, activatable_cards)
	local CMD_ATTACK = 1
	local CMD_ACTIVATE = 2
	local CMD_STOP = 0
	local command = 1
	local index = 1
	local function getWeakestAttack()
                local lowestAttack = -1
                local OppMon = AI.GetOppMonsterZones() 
		for i=1,#OppMon do
                    local c = OppMon[i]
                    if c ~= false and (lowestAttack == -1 or c.attack < lowestAttack) then
                        lowestAttack = c.attack
                    end
		end
		return lowestAttack
	end
	local function getHighestAttackerIndex()
		local highestIndex = 1
		local highestAttack = cards[1].attack
		for i=2,#cards do
			if cards[i].attack > highestAttack then
				highestIndex = i
				highestAttack = cards[i].attack
			end
		end
		return highestIndex
	end


	local function getOSBindex()
		local highestIndex = 1
		local AIMon = AI.GetAIMonsterZones()
		local highestAttack = -1
		for i=1,#AIMon do
			if AIMon[i] ~= false then
				if AIMon[i].attack > highestAttack then
					highestIndex = i
					highestAttack = AIMon[i].attack
				end
			end
		end
		return highestIndex
	end
	
	local function getAIWeakestAttackerIndex()
		local lowestIndex = 1
		local lowestAttack = cards[1].attack
		for i=2,#cards do
			if cards[i].attack < lowestAttack then
				lowestIndex = i
				lowestAttack = cards[i].attack
			end
		end
		return lowestIndex
	end

	if #cards > 0 and getWeakestAttack() ~= -1 then
                
		command = CMD_ATTACK
		index = getHighestAttackerIndex()
		OSBindex = getOSBindex()
                monattack = getWeakestAttack()
                if (cards[index].attack <= monattack) then
                    index = 0
                    command = CMD_STOP
                end
    	elseif #cards > 0 and getWeakestAttack() == -1 then
		command = CMD_ATTACK
		index = getAIWeakestAttackerIndex()
	elseif #activatable_cards > 0 then
                print("if3")
		command = CMD_ACTIVATE
		index = 1
	else
		command = CMD_STOP
		index = 0
	end
	return command,index
end

function OnSelectCard(cards, minTargets, maxTargets, triggeringID, triggeringCard)
  local result = {1}
  for i=1,minTargets do
  	result[i] = i
  end
  if Duel.GetCurrentPhase() == PHASE_BATTLE then
	local tblAI = {}
	local tblOpp = {}
  
	local AIMon = AI.GetAIMonsterZones()
  
	local AIOppMon = AI.GetOppMonsterZones()
  
	local tblcount = 1
	for i=1,#AIMon do
		if AIMon[i] ~= false then
			tblAI[tblcount] = AIMon[i]
			tblAI[tblcount].position = i
			tblcount = tblcount + 1
		end
	end
  
	table.sort(tblAI,
		function(a,b)
			return (a.attack < b.attack)
		end
		)
  
	local oppmoncount = 1
	for i=1, #AIOppMon do 
		if AIOppMon[i] ~= false then
			tblOpp[oppmoncount] = AIOppMon[i]
			tblOpp[oppmoncount].position = oppmoncount
			oppmoncount = oppmoncount + 1
		end
	end
	
	table.sort(tblOpp,
		function(a,b)
			return (a.attack < b.attack)
		end
		)
	
	for i=1, #tblOpp do -- attempt to get length of global 'tblOpp' (a nil value)
		if tblOpp[i] ~= false then
			if (AIMon[OSBindex].attack > tblOpp[i].attack) then
				result = {tblOpp[i].position}
			end
		end
	end
  end
  return result
end

COMMAND_LET_AI_DECIDE		= -1
COMMAND_SUMMON 				= 0
COMMAND_SPECIAL_SUMMON 		= 1
COMMAND_CHANGE_POS 			= 2
COMMAND_SET_MONSTER 		= 3
COMMAND_SET_ST 				= 4
COMMAND_ACTIVATE 			= 5
COMMAND_TO_NEXT_PHASE 		= 6
COMMAND_TO_END_PHASE 		= 7
function OnSelectInitCommand(cards, to_bp_allowed, to_ep_allowed)	
	if #cards.activatable_cards > 0 then
		return COMMAND_ACTIVATE,1
	end
	if #cards.spsummonable_cards > 0 then
		return COMMAND_SPECIAL_SUMMON,3
	end	
	if #cards.summonable_cards > 0 then
		return COMMAND_SUMMON,1
	end
	if #cards.monster_setable_cards > 0 then
		return COMMAND_SET_MONSTER,1
	end
	if #cards.st_setable_cards > 0 then
		
		if AI.GetCurrentPhase() == PHASE_MAIN1 and Duel.GetTurnCount() == 1 then
			local setCards = cards.st_setable_cards
			for i=1,#setCards do
				if bit32.band(setCards[i].type,TYPE_TRAP) > 0 then
					return COMMAND_SET_ST,i
				end
			end
		end
		if AI.GetCurrentPhase() == PHASE_MAIN2 then
			local setCards = cards.st_setable_cards
			for i=1,#setCards do
				if bit32.band(setCards[i].type,TYPE_TRAP) > 0 then
					return COMMAND_SET_ST,i
				end
			end
		end

	end
	if AI.GetCurrentPhase() == PHASE_MAIN1 and to_bp_allowed then
		return COMMAND_TO_NEXT_PHASE,1
	else
		return COMMAND_TO_END_PHASE,1
	end
end
