--
-- Three Bugs (Vem, Yauj & Kri) - Optional Boss in AQ40 
-- Mod by Nitram
--

DBM.AddOns.ThreeBugs = {
	["Name"] = DBM_THREEBUGS_NAME,
	["Abbreviation1"] = "Bugs",
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = DBM_THREEBUGS_DESCRIPTION,
	["Instance"] = DBM_AQ40,
	["GUITab"] = DBMGUI_TAB_AQ40,
	["Sort"] = 2,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
	},	
	["Events"] = {
		["SPELL_CAST_START"] = true,
		["SPELL_AURA_APPLIED"] = true,
	},
	["LastFear"] = 0,
	["OnEvent"] = function(event, arg1)

		if (event == "SPELL_CAST_START") then
			if arg1.spellId == 33387 then
				DBM.Announce(DBM_THREEBUGS_CASTHEAL_ANNOUNCE);
				DBM.StartStatusBarTimer(2, "Great Heal Cast", "Interface\\Icons\\Spell_Holy_Heal");
			end
		end

		if (event == "SPELL_AURA_APPLIED") then
		 	if (time() - DBM.AddOns.ThreeBugs.LastFear) > 10 and DBM.AddOns.ThreeBugs.InCombat then
				if arg1.spellName == DBM_THREEBUGS_FEAR_EXPR then
					DBM.AddOns.ThreeBugs.LastFear = time();
					DBM.Schedule(17, "DBM.AddOns.ThreeBugs.OnEvent", "FearIn3");	-- 20 Sec Fear

					DBM.EndStatusBarTimer("Yauj Fear");
					DBM.StartStatusBarTimer(20, "Yauj Fear", "Interface\\Icons\\Spell_Shadow_PsychicScream");
				end
			end
		end

		if (event == "FearIn3") then
			DBM.Announce(string.format(DBM_THREEBUGS_FEAR_ANNOUNCE, 3));
		end


	end,
	
};
