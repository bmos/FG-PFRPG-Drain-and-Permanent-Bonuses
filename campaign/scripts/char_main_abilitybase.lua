-- 
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onInit()
	if not DB.getValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.permbon') and not DB.getValue(window.getDatabaseNode(), target[1] .. 'permbon') then
		setValue(DB.getValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.score', 0))
		DB.setValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.permbon', 'number', 1)
	elseif not DB.getValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.permbon') and DB.getValue(window.getDatabaseNode(), target[1] .. 'permbon') then
		DB.setValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.permbon', 'number', 1)
	end
end

function onValueChanged()
	local nScore = getValue() + DB.getValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.perm', 0)
	DB.setValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.score', 'number', nScore)
end