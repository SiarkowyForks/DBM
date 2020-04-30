-- 
-- Azuregos (Azshara Dragon) beta v0.1
--

DBM.AddOns.Azuregos = { 
	["Name"] = DBM_AZUREGOS_NAME,
	["Abbreviation1"] = "Azu", 
	["Version"] = "0.1",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = DBM_AZUREGOS_INFO,
	["Instance"] = DBM_OTHER,
	["GUITab"] = DBMGUI_TAB_OTHER,
	["Sort"] = 4,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
	},
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["SPELL_AURA_APPLIED"] = true,
		["SPELL_AURA_REMOVED"] = true,
	},	
	["OnEvent"] = function(event, arg1)
		if( event == "SPELL_AURA_APPLIED" and arg1.spellId == 22067 ) then
			DBM.Announce(DBM_AZUREGOS_SHIELDUP_ANNOUNCE);

		elseif( event == "SPELL_AURA_REMOVED" and arg1.spellId == 22067 ) then
			DBM.Announce(DBM_AZUREGOS_SHIELDDOWN_ANNOUNCE);

		elseif( event == "CHAT_MSG_MONSTER_YELL" and arg1 == DBM_AZUREGOS_PORT_EXPR ) then
			DBM.Announce(DBM_AZUREGOS_PORT_ANNOUNCE);
			
		end
	end,
};
