-- 
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--
function onValueChanged()
	local nodeAbilities = window.getDatabaseNode().getChild('abilities')
	local nScore = DB.getValue(nodeAbilities, target[1] .. '.base', 0) + DB.getValue(nodeAbilities, target[1] .. '.perm', 0)

	DB.setValue(nodeAbilities, target[1] .. '.score', 'number', nScore)
end
