DBM.AddOns.Ebonroc = {
	["Name"] = DBM_EBONROC_NAME,
	["Abbreviation1"] = "ebon",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = DBM_EBONROC_DESCRIPTION,
	["Instance"] = DBM_BWL,
	["GUITab"] = DBMGUI_TAB_BWL,
	["Sort"] = 5,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["SetIcon"] = true,
	},
	["DropdownMenu"] = {	
		[1] = {
			["variable"] = "DBM.AddOns.Ebonroc.Options.SetIcon",
			["text"] = DBM_EBONROC_SET_ICON,
			["func"] = function() DBM.AddOns.Ebonroc.Options.SetIcon = not DBM.AddOns.Ebonroc.Options.SetIcon; end,
		},
	},
	["Events"] = {
		["SPELL_AURA_APPLIED"] = true,
		["SPELL_CAST_START"] = true,
	},	
	["OnCombatStart"] = function(delay)
		DBM.StartStatusBarTimer(31 - delay, "Wing Buffet", "Interface\\Icons\\INV_Misc_MonsterScales_14");
		DBM.Schedule(28 - delay, "DBM.AddOns.Ebonroc.OnEvent", "WingBuffetWarning", 3);
	end,
	["OnEvent"] = function(event, arg1)
		if event == "SPELL_CAST_START" then
			if arg1.spellName == DBM_BWLDRAKES_WINGBUFFET and arg1.sourceName == DBM_EBONROC_NAME then
				DBM.Announce(string.format(DBM_WING_BUFFET_WARNING, 1));
				DBM.StartStatusBarTimer(1, "Wing Buffet Cast", "Interface\\Icons\\INV_Misc_MonsterScales_14");
				DBM.Schedule(29, "DBM.AddOns.Ebonroc.OnEvent", "WingBuffetWarning", 3);
				DBM.Schedule(1, "DBM.AddOns.Ebonroc.OnEvent", "WingBuffetWarning", 31);
			elseif arg1.spellName == DBM_BWLDRAKES_SHADOWFLAME and arg1.sourceName == DBM_EBONROC_NAME then
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
			
		elseif event == "SPELL_AURA_APPLIED" then
			if arg1.spellId == 23340 then
				local name = tostring(arg1.destName)
				if DBM.AddOns.Ebonroc.Options.SetIcon then
					DBM.SetIconByName(name)
				end
				DBM.Announce(string.format(DBM_EBONROC_SHADOW_WARNING, name));
			end
		end
	end,
};
