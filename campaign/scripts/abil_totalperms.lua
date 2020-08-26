--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onInit()
	DB.addHandler('charsheet.*.abilities.*.abilperms.*.permnum', 'onUpdate', onPermUpdate)
	DB.addHandler('charsheet.*.abilities.*.abilperms', 'onChildDeleted', onPermUpdate)
end

local function addPerms(nodeAbil)
	local nPermTotal = 0
	for _,vNode in pairs(DB.getChildren(nodeAbil, 'abilperms')) do
		nPermTotal = nPermTotal + DB.getValue(vNode, 'permnum', 0)
	end
	
	DB.setValue(nodeAbil, 'perm', 'number', nPermTotal)
end

function onPermUpdate()
	if getDatabaseNode().getParent().getName() == 'abilities' then addPerms(getDatabaseNode()) end
end