--
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--
function onInit()
	local nodeChar = window.getDatabaseNode()
	local nodeAbilities = nodeChar.getChild('abilities')

	if not DB.getValue(nodeAbilities, target[1] .. '.permbon') and not DB.getValue(nodeChar, target[1] .. 'permbon') then
		setValue(DB.getValue(nodeAbilities, target[1] .. '.score', 0))
		DB.setValue(nodeAbilities, target[1] .. '.permbon', 'number', 1)
	elseif DB.getValue(nodeChar, target[1] .. 'permbon') then
		DB.setValue(nodeAbilities, target[1] .. '.permbon', 'number', 1)
		DB.deleteChild(nodeChar, target[1] .. 'permbon')
	end
end

function onValueChanged()
	local nodeAbilities = window.getDatabaseNode().getChild('abilities')
	local nScore = DB.getValue(nodeAbilities, target[1] .. '.base', 0) + DB.getValue(nodeAbilities, target[1] .. '.perm', 0)

	DB.setValue(nodeAbilities, target[1] .. '.score', 'number', nScore)
end
