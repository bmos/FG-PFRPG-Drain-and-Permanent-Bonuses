--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onInit()
	DB.addHandler('charsheet.*.abilities.*.abilperms.*.permnum', 'onUpdate', onPermUpdate)
	DB.addHandler('charsheet.*.abilities.*.abilperms.*.bonus_type', 'onUpdate', onPermUpdate)
	DB.addHandler('charsheet.*.abilities.*.abilperms', 'onChildDeleted', onPermUpdate)

	-- Include ability and character names in window title
	local sCharName = DB.getValue(getDatabaseNode().getChild('...'), 'name', '')
	local sAbility = getDatabaseNode().getName()
	title.setValue(StringManager.titleCase(sAbility) .. ' - ' .. sCharName)
end

function onClose()
	DB.removeHandler('charsheet.*.abilities.*.abilperms.*.permnum', 'onUpdate', onPermUpdate)
	DB.removeHandler('charsheet.*.abilities.*.abilperms.*.bonus_type', 'onUpdate', onPermUpdate)
	DB.removeHandler('charsheet.*.abilities.*.abilperms', 'onChildDeleted', onPermUpdate)
end


local function addPerms(nodeAbil)
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

function onPermUpdate()
	if getDatabaseNode().getParent().getName() == 'abilities' then addPerms(getDatabaseNode()) end
end