DBM.AddOns.Firemaw = {
	["Name"] = DBM_FIREMAW_NAME,
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = DBM_FIREMAW_DESCRIPTION,
	["Instance"] = DBM_BWL,
	["GUITab"] = DBMGUI_TAB_BWL,
	["Sort"] = 4,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["SPELL_CAST_START"] = true,
	},	
	["OnCombatStart"] = function(delay)
		DBM.StartStatusBarTimer(31 - delay, "Wing Buffet", "Interface\\Icons\\INV_Misc_MonsterScales_14");
		DBM.Schedule(28 - delay, "DBM.AddOns.Firemaw.OnEvent", "WingBuffetWarning", 3);
	end,
	["OnEvent"] = function(event, arg1)
		if event == "SPELL_CAST_START" then
			if arg1.spellName == DBM_BWLDRAKES_WINGBUFFET and arg1.sourceName == DBM_FIREMAW_NAME then
				DBM.Announce(string.format(DBM_WING_BUFFET_WARNING, 1));
				DBM.StartStatusBarTimer(1, "Wing Buffet Cast", "Interface\\Icons\\INV_Misc_MonsterScales_14");
				DBM.Schedule(29, "DBM.AddOns.Firemaw.OnEvent", "WingBuffetWarning", 3);
				DBM.Schedule(1, "DBM.AddOns.Firemaw.OnEvent", "WingBuffetWarning", 31);
			elseif arg1.spellName == DBM_BWLDRAKES_SHADOWFLAME and arg1.sourceName == DBM_FIREMAW_NAME then
				DBM.Announce(DBM_SHADOW_FLAME_WARNING);
				DBM.StartStatusBarTimer(2, "Shadow Flame Cast", "Interface\\Icons\\Spell_Fire_Incinerate");
			end
		elseif event == "WingBuffetWarning" then
			if arg1 == 3 then
				DBM.Announce(string.format(DBM_WING_BUFFET_WARNING, 3));
			elseif arg1 == 31 then
				DBM.EndStatusBarTimer("Wing Buffet");
				DBM.StartStatusBarTimer(31, "Wing Buffet", "Interface\\Icons\\INV_Misc_MonsterScales_14");
			end
		end
	end,
};
