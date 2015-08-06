math.randomseed( require("os").time() )
require("ai.ai")
--git test

function OnStartOfDuel()	
	AI.Chat("This is a tutorial AI file")
end

function OnSelectOption(options)
	return math.random(#options)
end

function OnSelectEffectYesNo(id, triggeringCard)
	return 1
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

function OnSelectCard(cards, minTargets, maxTargets, triggeringID, triggeringCard)
  local result = {1}
  AI.Chat("a")
  if Duel.GetCurrentPhase() == PHASE_BATTLE then
	AI.Chat("b")
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
		else
			print("No card aimon")
		end
	end
  
	table.sort(tblAI,
		function(a,b)
			return (a.attack < b.attack)
		end
		)
	for i=1,#tblAI do
		AI.Chat(tblAI[i].position)
		print(tblAI[i].attack)
	end
  
	local oppmoncount = 1
	for i=1, #AIOppMon do  -- tblOppにアクセスするとエラーが出る
		tblOpp[oppmoncount] = AIOppMon[i]
		tblOpp[oppmoncount].position = oppmoncount
		AI.Chat(tblOpp[oppmoncount].position)
		print("oppmon")
		oppmoncount = oppmoncount + 1
	end
	
	table.sort(tblOpp,
		function(a,b)
			return (a.attack < b.attack)
		end
		)
	end
		
  
  
  
  --[[for i=1,#AIMon do
                        tblAI[i] = AIMon[i]
                end
                table.sort(tblAI,
                        function(a,b)
                                return (a.attack < b.attack)
                        end
                )
                for k=1,#AIOppMon do
                        tblOpp[k] = AIOppMon[k]
                end
                table.sort(tblOpp,
                        function(a,b)
                                return (a.attack < b.attack)
                        end
                )
        end]]
--[[        local attackTarget=1
        for i=1,#tblAI do
                for k=1,#tblOpp do        
                        if (tblAI[i].attack > tblOpp[k].attack) then
                                attackTarget = tblOpp[k] ]]
        
  for i=1,minTargets do
    result[i]=i
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

    AI.Chat("OnSelectBattleCommand")
    AI.Chat(#cards,#activatable_cards)
	
	if #cards > 0 and getWeakestAttack() ~= -1 then
		command = CMD_ATTACK
		index = getHighestAttackerIndex()
                monattack = getWeakestAttack()
                if (cards[index].attack <= monattack) then
                    index = 0
                    command = CMD_STOP
                end
    elseif #cards > 0 and getWeakestAttack() == -1 then --ゴーズケア
		command = CMD_ATTACK
		index = getAIWeakestAttackerIndex()
	elseif #activatable_cards > 0 then
		command = CMD_ACTIVATE
		index = 1
	else
		command = CMD_STOP
		index = 0
	end
	return command,index
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
		return COMMAND_SPECIAL_SUMMON,1
	end	
	if #cards.summonable_cards > 0 then
		return COMMAND_SUMMON,1
	end
	if #cards.monster_setable_cards > 0 then
		return COMMAND_SET_MONSTER,1
	end
	if #cards.st_setable_cards > 0 and AI.GetCurrentPhase() == PHASE_MAIN2 then
		local setCards = cards.st_setable_cards
		for i=1,#setCards do
			if bit32.band(setCards[i].type,TYPE_TRAP) > 0 then
				return COMMAND_SET_ST,i
			end
		end
	end
	if AI.GetCurrentPhase() == PHASE_MAIN1 and to_bp_allowed then
		return COMMAND_TO_NEXT_PHASE,1
	else
		return COMMAND_TO_END_PHASE,1
	end
end
