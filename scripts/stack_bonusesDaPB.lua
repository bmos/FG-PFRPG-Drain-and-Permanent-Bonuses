-- 
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onInit()
	if User.isHost() then
		DB.addHandler(DB.getPath('combattracker.list.*.effects.*.label'), 'onUpdate', onEffectChanged)
		DB.addHandler(DB.getPath('combattracker.list.*.effects.*.isactive'), 'onUpdate', onEffectChanged)
		DB.addHandler(DB.getPath('combattracker.list.*.effects'), 'onChildDeleted', onEffectRemoved)
	end
end

function onEffectChanged(node)
	local rActor = ActorManager.getActor('ct', node.getChild('....'))
	if rActor.sType == 'pc' then
		local nodeChar = DB.findNode(rActor.sCreatureNode)
		onEffect(nodeChar)
	end
end

function onEffectRemoved(node)
	local rActor = ActorManager.getActor('ct', node.getChild('..'))
	if rActor.sType == 'pc' then
		local nodeChar = DB.findNode(rActor.sCreatureNode)
		onEffect(nodeChar)
	end
end

function onEffect(nodeChar)
	for _,nodeAbil in pairs(DB.getChildren(nodeChar, 'abilities')) do
		addPerms(nodeAbil)
	end
end

function addPerms(nodeAbil)
	local rActor = ActorManager.getActor('pc', nodeAbil.getChild('...'))
	
	local sAbil = ''
	if nodeAbil.getName() == 'strength' then sAbil = 'STR' end
	if nodeAbil.getName() == 'dexterity' then sAbil = 'DEX' end
	if nodeAbil.getName() == 'constitution' then sAbil = 'CON' end
	if nodeAbil.getName() == 'intelligence' then sAbil = 'INT' end
	if nodeAbil.getName() == 'wisdom' then sAbil = 'WIS' end
	if nodeAbil.getName() == 'charisma' then sAbil = 'CHA' end
	
	local aBonuses = {}
	for _,vNode in pairs(DB.getChildren(nodeAbil, 'abilperms')) do
		local nPerm = DB.getValue(vNode, 'permnum', 0)
		local sType = DB.getValue(vNode, 'bonus_type', 0)

		if nPerm > 0 then
			-- Don't stack bonuses of the same type
			if aBonuses[sType] then
				aBonuses[sType] = math.max(aBonuses[sType], nPerm)
			else
				aBonuses[sType] = nPerm
			end
		else
			-- Stack all penalties
			table.insert(aBonuses, nPerm)
		end
	end
	
	local nPermTotal = 0
	for sType,vPerm in pairs(aBonuses) do
		local nTempBonus = EffectManagerDaPB.getEffectsByType(rActor, sAbil, sType, aFilter, rFilterActor, bTargetedOnly)
		local nPerm = 0
		if vPerm > nTempBonus then
			nPerm = vPerm - nTempBonus
		else
			nPerm = vPerm
		end
		nPermTotal = nPermTotal + nPerm
	end
	
	DB.setValue(nodeAbil, 'perm', 'number', nPermTotal)
end
