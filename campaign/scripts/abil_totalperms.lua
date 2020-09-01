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

function onPermUpdate()
	if getDatabaseNode().getParent().getName() == 'abilities' then StackDaPB.addPerms(getDatabaseNode()) end
end