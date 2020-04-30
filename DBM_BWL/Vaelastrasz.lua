DBM.AddOns.Vaelastrasz = {
	["Name"] = DBM_VAEL_NAME,
	["Abbreviation1"] = "vael",
	["Version"] = "1.0",
	["Author"] = "Tandanu",
	["Description"] = DBM_VAEL_DESCRIPTION,
	["Instance"] = DBM_BWL,
	["GUITab"] = DBMGUI_TAB_BWL,
	["Sort"] = 2,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["Whisper"] = false,
		["SetIcon"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "DBM.AddOns.Vaelastrasz.Options.Whisper",
			["text"] = DBM_VAEL_SEND_WHISPER,
			["func"] = function() DBM.AddOns.Vaelastrasz.Options.Whisper = not DBM.AddOns.Vaelastrasz.Options.Whisper; end,
		},
		[2] = {
			["variable"] = "DBM.AddOns.Vaelastrasz.Options.SetIcon",
			["text"] = DBM_VAEL_SET_ICON,
			["func"] = function() DBM.AddOns.Vaelastrasz.Options.SetIcon = not DBM.AddOns.Vaelastrasz.Options.SetIcon; end,
		},
	},
	["Events"] = {
		["SPELL_AURA_APPLIED"] = true,
	},	
	["OnCombatEnd"] = function()
		if( DBM.AddOns.Vaelastrasz.Options.SetIcon ) then
			DBM.CleanUp();
		end
	end,		
	["OnEvent"] = function(event, args)
		if event == "SPELL_AURA_APPLIED" then	
			if args.spellId == 18173 or args.spellId == 23620 then
				local name = tostring(args.destName)
				if DBM.AddOns.Vaelastrasz.Options.SetIcon then
					DBM.SetIconByName(name)
				end
				DBM.Announce(string.format(DBM_VAEL_BA_WARNING, name));
				if name == UnitName("player") then
					DBM.AddSpecialWarning(DBM_VAEL_BA, true, true);
				else
					if DBM.AddOns.Vaelastrasz.Options.Whisper then
						DBM.SendHiddenWhisper(DBM_VAEL_BA_WHISPER, name);
					end
				end
			end		
		end
	end,
};
