--
--	Please see the LICENSE.md file included with this distribution for attribution and copyright information.
--
local function handleRacialAbilities_new(nodeChar, sText)
	local aWords = StringManager.parseWords(sText:lower());

	local aIncreases = {};
	local bChoice = false;
	local i = 1;
	while aWords[i] do
		if StringManager.isNumberString(aWords[i]) then
			local nMod = tonumber(aWords[i]) or 0;
			if nMod ~= 0 then
				if StringManager.contains(DataCommon.abilities, aWords[i + 1]) then
					aIncreases[aWords[i + 1]] = nMod;
				elseif StringManager.contains(DataCommon.abilities, aWords[i - 1]) then
					aIncreases[aWords[i - 1]] = nMod;
				else
					local j = i + 1;
					if StringManager.isWord(aWords[j], 'bonus') then j = j + 1; end
					if StringManager.isPhrase(aWords, j, { 'to', 'one', 'ability', 'score' }) then bChoice = true; end
				end
			end
		end
		i = i + 1;
	end

	local bApplied = false;
	for k, v in pairs(aIncreases) do
		if StringManager.contains(DataCommon.abilities, k) then
			local nodeAbility = nodeChar.getChild('abilities.' .. k)
			local nodeAbilityPerm = nodeAbility.createChild('abilperms').createChild()
			DB.setValue(nodeAbilityPerm, 'name', 'string', 'Racial Attribute Adjustments');
			DB.setValue(nodeAbilityPerm, 'bonus_type', 'string', 'racial');
			DB.setValue(nodeAbilityPerm, 'permnum', 'number', v);
			Interface.openWindow('charsheet_abilities_perms', nodeAbility)
			Interface.toggleWindow('charsheet_abilities_perms', nodeAbility)
			bApplied = true;
		end
	end

	if bChoice then
		local aAbilities = {};
		for _, v in ipairs(DataCommon.abilities) do table.insert(aAbilities, StringManager.capitalize(v)); end
		local wSelect = Interface.openWindow('select_dialog', '');
		local sTitle = Interface.getString('char_title_selectabilityincrease');
		local sMessage = Interface.getString('char_message_selectabilityincrease');
		wSelect.requestSelection(sTitle, sMessage, aAbilities, CharManager.onRaceAbilitySelect, nodeChar, 1);
		bApplied = true;
	end

	return bApplied;
end

function onInit()
	CharManager.handleRacialAbilities = handleRacialAbilities_new
end