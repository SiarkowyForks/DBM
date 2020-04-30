DBM.AddOns.Shazzrah = { 
	["Name"] = DBM_SHAZZRAH_NAME,
	["Abbreviation1"] = "Shazz", 
	["Version"] = "1.1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = DBM_SHAZZRAH_INFO,
	["Instance"] = DBM_MC,
	["GUITab"] = DBMGUI_TAB_MC,
	["Sort"] = 6,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Curse"] = false,
	["Events"] = {
		["SPELL_CAST_SUCCESS"] = true,
	},	
	["OnEvent"] = function(event, arg1)
		if event == "SPELL_CAST_SUCCESS" then
			if arg1.spellId == 19713 then
				DBM.Announce(DBM_SHAZZRAH_CURSE_WARNING);
				DBM.Schedule(15, "DBM.AddOns.Lucifron.OnEvent", "CurseWarning", 5);
				DBM.EndStatusBarTimer("Curse");
				DBM.StartStatusBarTimer(20, "Curse", "Interface\\Icons\\Spell_Shadow_AntiShadow");
			end
		elseif ( event == "CurseWarning" ) then
			if arg1 then
				DBM.Announce(string.format(DBM_SHAZZRAH_CURSE_SOON_WARNING, arg1))
			end
		end
	end,		
};
