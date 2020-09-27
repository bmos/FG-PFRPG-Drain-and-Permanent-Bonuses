-- 
-- Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--

function onValueChanged()
	local nScore = getValue() + DB.getValue(window.getDatabaseNode(), 'abilities.' .. target[1] .. '.base', 0)
	DB.setValue(window.getDatabaseNode().getChild('abilities'), target[1] .. '.score', 'number', nScore)
end