DBM.AddOns.Defender = {
	["Name"] = DBM_DEFENDER_NAME,
	["Abbreviation1"] = "Defender",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = DBM_DEFENDER_DESCRIPTION,
	["Instance"] = DBM_AQ40,
	["GUITab"] = DBMGUI_TAB_AQ40,
	["Sort"] = 5.5,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["Plague"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "DBM.AddOns.Defender.Options.Whisper",
			["text"] = DBM_DEFENDER_WHISPER,
			["func"] = function() DBM.AddOns.Defender.Options.Whisper = not DBM.AddOns.Defender.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "DBM.AddOns.Defender.Options.Plague",
			["text"] = DBM_DEFENDER_PLAGUE,
			["func"] = function() DBM.AddOns.Defender.Options.Plague = not DBM.AddOns.Defender.Options.Plague; end,
		},
	},
	["Events"] = {
		["SPELL_AURA_APPLIED"] = true,
	},	
	
	["OnEvent"] = function(event, arg1)	
		if (event == "SPELL_AURA_APPLIED") then
			if arg1.spellName == DBM_DEFENDER_GAIN_EXPLODE then
				DBM.Announce(DBM_DEFENDER_ANNOUNCE_EXPLODE);
				DBM.StartStatusBarTimer(6, "Explode", "Interface\\Icons\\Spell_Fire_SelfDestruct");
			elseif arg1.spellId == 26556 then
				local player = arg1.destName
				if player then
					if DBM.AddOns.Defender.Options.Plague then
						DBM.Announce(string.format(DBM_DEFENDER_ANNOUNCE_PLAGUE, player));
					end
					if player == UnitName("player") then
						DBM.AddSpecialWarning(DBM_DEFENDER_PLAGUE_WARNING, true, true);
					else
						if DBM.AddOns.Defender.Options.Whisper then
							DBM.SendHiddenWhisper(DBM_DEFENDER_WHISPER_PLAGUE, player);					
						end
					end
				end
			end
		end
   end,   
};
