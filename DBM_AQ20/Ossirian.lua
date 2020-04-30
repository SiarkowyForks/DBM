-- 
-- Ossirian the Unscarred v1.0
--

DBM.AddOns.Ossirian = { 
	["Name"] = DBM_OSSIRIAN_NAME,
	["Abbreviation1"] = "Ossirian", 
	["Version"] = "1.0",
	["Author"] = "La Vendetta|Nitram",
	["Description"] = DBM_OSSIRIAN_INFO,
	["Instance"] = DBM_AQ20,
	["GUITab"] = DBMGUI_TAB_AQ20,
	["Options"] = {  
		["Enabled"] = true,
		["Announce"] = false,
		["AnnounceCurse"] = false,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "DBM.AddOns.Ossirian.Options.AnnounceCurse",
			["text"] = DBM_OSSIRIAN_CURSE_INFO,
			["func"] = function() DBM.AddOns.Ossirian.Options.AnnounceCurse = not DBM.AddOns.Ossirian.Options.AnnounceCurse; end,
		},
	},
	["Sort"] = 16,
	["LastCurse"] = 0,
	["Events"] = {
		["SPELL_AURA_APPLIED"] = true,
		["CHAT_MSG_MONSTER_YELL"] = true,
	},	
	["OnEvent"] = function(event, arg1) 

		-- Announce Curse of Ossirian
		if (time() - DBM.AddOns.Ossirian.LastCurse) > 10
		    and event == "SPELL_AURA_APPLIED"
			and arg1.spellName == DBM_OSSIRIAN_CURSE_EXPR then


				DBM.AddOns.Ossirian.LastCurse = time();
		    		if( DBM.AddOns.Ossirian.Options.AnnounceCurse ) then
					DBM.Announce( DBM_OSSIRIAN_CURSE_ANNOUNCE );
					DBM.Schedule(18, "DBM.AddOns.Ossirian.OnEvent", "CurseWarning5");
				end
			
				DBM.EndStatusBarTimer("Ossirians Curse");
				DBM.StartStatusBarTimer(23, "Ossirians Curse", "Interface\\Icons\\Spell_Shadow_CurseOfTounges");

		elseif( event == "CurseWarning5" and DBM.AddOns.Ossirian.Options.AnnounceCurse ) then
			DBM.Announce( DBM_OSSIRIAN_CURSE_PREANNOUNCE );
		end
				
		-- Announce vulnerability
		if ( event == "SPELL_AURA_APPLIED" ) then
			if arg1.spellName then
				local _, _, sArg1 = string.find(arg1.spellName, DBM_OSSIRIAN_WEAK_EXPR);
			
				if ( sArg1 ) and ( sArg1 ~= DBM_OSSIRIAN_EXPOSE ) then
					DBM.Announce( string.format(DBM_OSSIRIAN_WEAK_ANNOUNCE, sArg1) );
					DBM.UnSchedule("DBM.AddOns.Ossirian.OnEvent", "Supreme25");
					DBM.UnSchedule("DBM.AddOns.Ossirian.OnEvent", "Supreme15");
					DBM.UnSchedule("DBM.AddOns.Ossirian.OnEvent", "Supreme10");
					DBM.Schedule(20, "DBM.AddOns.Ossirian.OnEvent", "Supreme25");
					DBM.Schedule(30, "DBM.AddOns.Ossirian.OnEvent", "Supreme15");
					DBM.Schedule(35, "DBM.AddOns.Ossirian.OnEvent", "Supreme10");
					
					if sArg1 == "Arkan" then sArg1 = "Arcane"; --you may _never_ use localized strings to start status bars...use the DBM_SBT table to localize status bar strings!
					elseif sArg1 == "Feuer" then sArg1 = "Fire";
					elseif sArg1 == "Frost" then sArg1 = "Frost";
					elseif sArg1 == "Natur" then sArg1 = "Nature";
					elseif sArg1 == "Schatten" then sArg1 = "Shadow";
					end
					
					DBM.EndStatusBarTimer(sArg1.." vulnerability");
					
					local icon;
					if sArg1 == DBM_ARCANE then
						icon = "Interface\\Icons\\INV_Misc_QirajiCrystal_01";
					elseif sArg1 == DBM_FIRE then
						icon = "Interface\\Icons\\INV_Misc_QirajiCrystal_02";
					elseif sArg1 == DBM_NATURE then
						icon = "Interface\\Icons\\INV_Misc_QirajiCrystal_03";
					elseif sArg1 == DBM_FROST then
						icon = "Interface\\Icons\\INV_Misc_QirajiCrystal_04";
					elseif sArg1 == DBM_SHADOW then
						icon = "Interface\\Icons\\INV_Misc_QirajiCrystal_05";
					end
					DBM.StartStatusBarTimer(45, sArg1.." vulnerability", icon);
				end
			end
		elseif( event == "Supreme25" ) then	DBM.Announce( string.format(DBM_OSSIRIAN_WEAK_RUNOUT, 25) );
		elseif( event == "Supreme15" ) then	DBM.Announce( string.format(DBM_OSSIRIAN_WEAK_RUNOUT, 15) );
		elseif( event == "Supreme10" ) then	DBM.Announce( string.format(DBM_OSSIRIAN_WEAK_RUNOUT, 10) );
		end

		-- Supreme Mode warning
		if event == "SPELL_AURA_APPLIED" and arg1.spellId == DBM_OSSIRIAN_SPELLID_SUPREME then
			DBM.Announce( DBM_OSSIRIAN_SUPREME_ANNOUNCE );

			DBM.UnSchedule("DBM.AddOns.Ossirian.OnEvent", "Supreme25");
			DBM.UnSchedule("DBM.AddOns.Ossirian.OnEvent", "Supreme15");
			DBM.UnSchedule("DBM.AddOns.Ossirian.OnEvent", "Supreme10");
			DBM.EndStatusBarTimer("Ossirians weakening");
		end
	
		-- Ossirian dies
		if ( event == "CHAT_MSG_MONSTER_YELL" and arg1 == DBM_OSSIRIAN_DEATH_EXPR ) then
			DBM.UnSchedule("DBM.AddOns.Ossirian.OnEvent");
			DBM.EndStatusBarTimer("Ossirians weakening");
			DBM.EndStatusBarTimer("Ossirians Curse");
		end

	end,		
};
