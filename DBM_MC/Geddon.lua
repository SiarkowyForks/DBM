DBM.AddOns.Geddon = { 
	["Name"] = DBM_BARON_NAME,
	["Abbreviation1"] = "Geddon", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = DBM_BARON_INFO,
	["Instance"] = DBM_MC,
	["GUITab"] = DBMGUI_TAB_MC,
	["Sort"] = 5,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["SetIcon"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "DBM.AddOns.Geddon.Options.Whisper",
			["text"] = DBM_BARON_SEND_WHISPER,
			["func"] = function() DBM.AddOns.Geddon.Options.Whisper = not DBM.AddOns.Geddon.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "DBM.AddOns.Geddon.Options.SetIcon",
			["text"] = DBM_BARON_SET_ICON,
			["func"] = function() DBM.AddOns.Geddon.Options.SetIcon = not DBM.AddOns.Geddon.Options.SetIcon; end,
		},
	},
	["Events"] = {
		["SPELL_AURA_APPLIED"] = true,
	},	
	["OnCombatEnd"] = function()
		if( DBM.AddOns.Geddon.Options.SetIcon ) then
			DBM.CleanUp();
		end
	end,
	["OnEvent"] = function(event, arg1) 
		if ( event == "SPELL_AURA_APPLIED" ) then
			if arg1.spellId == 19695 then
				DBM.Announce(DBM_BARON_INFERNO_WARNING);
				DBM.StartStatusBarTimer(8, "Inferno", "Interface\\Icons\\Spell_Fire_Incinerate");
			elseif arg1.spellId == 20475 then
				local target = tostring(arg1.destName)
				if target == UnitName("player") then
					DBM.AddSpecialWarning(DBM_BARON_BOMB_WHISPER);					
				end
				if( DBM.AddOns.Geddon.Options.Whisper ) then
					DBM.SendHiddenWhisper(DBM_BARON_BOMB_WHISPER, target);
				end
				DBM.Announce(string.format(DBM_BARON_BOMB_WARNING, target));
				if DBM.AddOns.Geddon.Options.SetIcon then
					DBM.SetIconByName(target, 8)
				end
			end
		end
	end,		
};
