-- 
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onInit()
	if not DB.getValue(window.getDatabaseNode(), 'permbon') then
		setValue(DB.getValue(window.getDatabaseNode(), 'abilities.' .. target[1] .. '.score', 0))
		DB.setValue(window.getDatabaseNode(), 'permbon', 'number', 1)
	end
end
function onValueChanged()
	local nScore = getValue() + DB.getValue(window.getDatabaseNode(), 'abilities.' .. target[1] .. '.perm', 0)
	DB.setValue(window.getDatabaseNode(), 'abilities.' .. target[1] .. '.score', 'number', nScore)
end