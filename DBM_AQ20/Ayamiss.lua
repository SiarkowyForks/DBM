-- 
-- Ayamiss the Hunter Beta v0.1
--

DBM.AddOns.Ayamiss = { 
	["Name"] = DBM_AYAMISS_NAME,
	["Abbreviation1"] = "Ayamiss", 
	["Version"] = "0.1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = DBM_AYAMISS_INFO,
	["Instance"] = DBM_AQ20,
	["GUITab"] = DBMGUI_TAB_AQ20,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Sort"] = 15,
	["Events"] = {
		["SPELL_AURA_APPLIED"] = true
	},	
	["OnEvent"] = function(event, args) 
			if args.spellId == DBM_AYAMISS_SPELLID_SACRIFICE then			
				DBM.Announce(string.format(DBM_AYAMISS_SACRIFICE_ANNOUNCE, tostring(args.destName)))
			end
	end,		
};
