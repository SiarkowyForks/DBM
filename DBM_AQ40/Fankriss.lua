DBM.AddOns.Fankriss = {
	["Name"] = DBM_FANKRISS_NAME,
	["Abbreviation1"] = "FANKRISS",
	["Version"] = "1.5",
	["Author"] = "Tandanu",
	["Description"] = DBM_FANKRISS_DESCRIPTION,
	["Instance"] = DBM_AQ40,
	["GUITab"] = DBMGUI_TAB_AQ40,
	["Sort"] = 4,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},	
	["Events"] = {
		["SPELL_CAST_SUCCESS"] = true,
	},	

	["OnEvent"] = function(event, arg1)
		if (event == "SPELL_CAST_SUCCESS") then
			if arg1.spellId == 25832 or arg1.spellId == 25831 then
				DBM.Announce(DBM_FANKRISS_SPAWN_WARNING);
			end
		end
	end,
};
