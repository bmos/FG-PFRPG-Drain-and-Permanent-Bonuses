--
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--
-- luacheck: globals onValueChanged target
function onValueChanged()
	local nodeAbilities = DB.getChild(window.getDatabaseNode(), 'abilities')
	local nScore = DB.getValue(nodeAbilities, target[1] .. '.base', 0) + DB.getValue(nodeAbilities, target[1] .. '.perm', 0)

	DB.setValue(nodeAbilities, target[1] .. '.score', 'number', nScore)
end
