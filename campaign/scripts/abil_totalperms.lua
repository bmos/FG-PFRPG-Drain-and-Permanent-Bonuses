--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

local function addPerms(nodeAbil)
	local aBonuses = {}
	for _,vNode in pairs(DB.getChildren(nodeAbil, 'abilperms')) do
		local nPerm = DB.getValue(vNode, 'permnum', 0)
		local sType = DB.getValue(vNode, 'bonus_type', 0)

		if nPerm > 0 then
			if (sType == 'circumstance') or (sType == 'dodge') or (sType == 'untyped') then
				if aBonuses[sType] then aBonuses[sType] = (aBonuses[sType] + nPerm) end
				if not aBonuses[sType] then aBonuses[sType] = nPerm end
			else
				if aBonuses[sType] then aBonuses[sType] = math.max(aBonuses[sType], nPerm) end
				if not aBonuses[sType] then aBonuses[sType] = nPerm end
			end
		else
			table.insert(aBonuses, nPerm)
		end
	end

	local nPermTotal = 0
	for _,nPerm in pairs(aBonuses) do
		nPermTotal = nPermTotal + nPerm
	end
	
	DB.setValue(nodeAbil, 'perm', 'number', nPermTotal)
end

function onPermUpdate()
	if getDatabaseNode().getParent().getName() == 'abilities' then addPerms(getDatabaseNode()) end
end

function onInit()
	DB.addHandler('charsheet.*.abilities.*.abilperms.*.permnum', 'onUpdate', onPermUpdate)
	DB.addHandler('charsheet.*.abilities.*.abilperms.*.bonus_type', 'onUpdate', onPermUpdate)
	DB.addHandler('charsheet.*.abilities.*.abilperms', 'onChildDeleted', onPermUpdate)

	local sCharName = DB.getValue(getDatabaseNode().getChild('...'), 'name', '')
	local sAbility = getDatabaseNode().getName()
	title.setValue(StringManager.titleCase(sAbility) .. ' - ' .. sCharName)

	onPermUpdate()
end