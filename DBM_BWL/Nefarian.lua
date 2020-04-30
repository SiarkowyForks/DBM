
DBM.AddOns.Nefarian = {
	["Name"] = DBM_NEFARIAN_NAME,
	["Abbreviation1"] = "nef",
	["Version"] = "1.1",
	["Author"] = "Tandanu",
	["Description"] = DBM_NEFARIAN_DESCRIPTION,
	["Instance"] = DBM_BWL,
	["GUITab"] = DBMGUI_TAB_BWL,
	["Sort"] = 8,
	["Options"] = {
		["Enabled"] = true,
		["Announce"] = false,
		["UnequipBow"] = false,
		["SyncKills"] = true,
		["FirstTimeLoaded"] = true,
	},
	["DropdownMenu"] = {
		[1] = {
			["variable"] = "DBM.AddOns.Nefarian.Options.UnequipBow",
			["text"] = DBM_NEFARIAN_UNEQUIP_BOW,
			["func"] = function() DBM.AddOns.Nefarian.Options.UnequipBow = not DBM.AddOns.Nefarian.Options.UnequipBow; end,
		},
		[2] = {
			["variable"] = "DBM.AddOns.Nefarian.Options.SyncKills",
			["text"] = DBM_NEFARIAN_SYNCKILLS_INFO,
			["func"] = function() DBM.AddOns.Nefarian.Options.SyncKills = not DBM.AddOns.Nefarian.Options.SyncKills; end,
		},
	},
	["LocalDrakonids"] = { 
		[1] = 0, 
		[2] = 0, 
		[3] = 0, 
		[4] = 0, 
		[5] = 0, 
		[6] = 0, 
	},
	["SyncedDrakonids"] = { 
		[1] = 0, 
		[2] = 0, 
		[3] = 0, 
		[4] = 0, 
		[5] = 0, 
		[6] = 0, 
	},
	["SideColor"] = 0,
	["LastCountMsg"] = 0,
	["BowBag"]	= 0,
	["BowSlot"] = 0,
	["BowUnequipped"] = false,
	["Phase"] = 1,
	["Events"] = {
		["CHAT_MSG_MONSTER_YELL"] = true,
		["SPELL_CAST_START"] = true,
		["CHAT_MSG_ADDON"] = true,
		["UNIT_DIED"] = true,
	},
	["OnLoad"] = function()
		if DBM.AddOns.Nefarian.Options.FirstTimeLoaded then
			DBM.AddOns.Nefarian.Options.FirstTimeLoaded	= false;
			DBM.AddOns.Nefarian.Options.UnequipBow		= false;
		end
	end,
	["OnCombatStart"] = function(delay)
		for i = 1, 6 do
			DBM.AddOns.Nefarian.LocalDrakonids[i] = 0;
		end
		for i = 1, 6 do
			DBM.AddOns.Nefarian.SyncedDrakonids[i] = 0;
		end
		DBM.AddOns.Nefarian.Phase = 1;
		
		if DBM.SyncInfo and DBM.SyncInfo.Clients then
			local goodVersionCounter = 0;
			for index, value in pairs(DBM.SyncInfo.Clients) do
				if (tonumber(value) or 0) >= 2.2 then
					goodVersionCounter = goodVersionCounter + 1;
					if goodVersionCounter >= 2 then
						break;
					end
				end
			end
			
			if goodVersionCounter < 2 then
				DBM.AddMsg(DBM_NEFARIAN_ERROR_NO_SYNC);
			end
		end
	end,
	["OnCombatEnd"] = function()
		for i = 1, 6 do
			DBM.AddOns.Nefarian.LocalDrakonids[i] = 0;
		end
		for i = 1, 6 do
			DBM.AddOns.Nefarian.SyncedDrakonids[i] = 0;
		end
		DBM.AddOns.Nefarian.SideColor = 0;
		DBM.AddOns.Nefarian.LastCountMsg = 0;
	end,
	["OnStop"] = function()
		for i = 1, 6 do
			DBM.AddOns.Nefarian.LocalDrakonids[i] = 0;
		end
		for i = 1, 6 do
			DBM.AddOns.Nefarian.SyncedDrakonids[i] = 0;
		end
	end,
	["OnEvent"] = function(event, arg1)


		if DBM.AddOns.Nefarian.Options.SyncKills and event == "CHAT_MSG_ADDON" and arg1 == "LVNEF" and arg2 and arg3 == "RAID" and arg4 ~= UnitName("player") and (DBM.AddOns.Nefarian.Phase == 1) then
			local count = 0;
			local syncKills = {};
			_, _, syncKills[1], syncKills[2], syncKills[3], syncKills[4], syncKills[5], syncKills[6] = string.find(arg2, "(%d+)~(%d+)~(%d+)~(%d+)~(%d+)~(%d+)~");
			
			for i = 1, 6 do
				if (tonumber(syncKills[i]) or 0) > DBM.AddOns.Nefarian.SyncedDrakonids[i] then
					DBM.AddOns.Nefarian.SyncedDrakonids[i] = (tonumber(syncKills[i]) or 0);
				end
			end
			
			for i = 1, 6 do
				if DBM.AddOns.Nefarian.SyncedDrakonids[i] > DBM.AddOns.Nefarian.LocalDrakonids[i] then
					count = count + DBM.AddOns.Nefarian.SyncedDrakonids[i];
				else
					count = count + DBM.AddOns.Nefarian.LocalDrakonids[i];
				end
			end
			
			if( count > 3 and (time() - DBM.AddOns.Nefarian.LastCountMsg) > 10 ) then
				DBM.AddOns.Nefarian.LastCountMsg = time();
				DBM.Announce( string.format(DBM_NEFARIAN_SYNCKILLS_ANNOUNCE, count) );
			end

		elseif DBM.AddOns.Nefarian.Options.SyncKills and event == "UNIT_DIED" and DBM.AddOns.Nefarian.Phase == 1 then
			local foundKill;
			for i = 1, 6 do
				if( DBM_NEFARIAN_DRAKONID_DOWN[i] == arg1.destName ) then
					DBM.AddOns.Nefarian.LocalDrakonids[i] = DBM.AddOns.Nefarian.LocalDrakonids[i] + 1;
					foundKill = true;
					break;
				end
			end
			if not foundKill then
				return;
			end
			
			local syncString = "";
			for i = 1, 6 do
				syncString = syncString..tostring(DBM.AddOns.Nefarian.LocalDrakonids[i]).."~";
			end
			
			SendAddonMessage("LVNEF", syncString, "RAID");

		elseif event == "SPELL_CAST_START" then
			if arg1.spellName == DBM_BWLDRAKES_SHADOWFLAME and arg1.sourceName == DBM_NEFARIAN_NAME then
				DBM.Announce(DBM_SHADOW_FLAME_WARNING);
				DBM.StartStatusBarTimer(2, "Shadow Flame Cast", "Interface\\Icons\\Spell_Fire_Incinerate");
			elseif arg1.spellId == 22686 then -- ?
				DBM.Announce(DBM_NEFARIAN_FEAR_WARNING);
				DBM.StartStatusBarTimer(1.5, "Fear Cast", "Interface\\Icons\\Spell_Shadow_PsychicScream");
			end
		elseif event == "CHAT_MSG_MONSTER_YELL" then
			if arg1 == DBM_NEFARIAN_YELL_PHASE2 then
				DBM.Announce(DBM_NEFARIAN_PHASE2_WARNING);
				DBM.AddOns.Nefarian.Phase = 2;
				DBM.StartStatusBarTimer(15, "Phase 2");
			elseif arg1 == DBM_NEFARIAN_YELL_PHASE3 then
				DBM.Announce(DBM_NEFARIAN_PHASE3_WARNING);
			elseif (string.find(arg1, DBM_NEFARIAN_YELL_SHAMANS)) then
				DBM.Announce(DBM_NEFARIAN_SHAMAN_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Class call CD", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_PALAS then
				DBM.Announce(DBM_NEFARIAN_PALA_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Class call CD", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_DRUIDS then
				DBM.Announce(DBM_NEFARIAN_DRUID_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Druid call", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_PRIESTS then
				if UnitClass("player") == DBM_PRIEST then
					DBM.AddSpecialWarning(DBM_NEFARIAN_PRIEST_CALL, true, true);
				end
				DBM.Announce(DBM_NEFARIAN_PRIEST_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Priest call", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_WARRIORS then
				DBM.Announce(DBM_NEFARIAN_WARRIOR_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Warrior call", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_ROGUES then
				DBM.Announce(DBM_NEFARIAN_ROGUE_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Rogue call", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_WARLOCKS then
				DBM.Announce(DBM_NEFARIAN_WARLOCK_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Class call CD", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_HUNTERS then
				DBM.Announce(DBM_NEFARIAN_HUNTER_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Class call CD", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_MAGES then
				DBM.Announce(DBM_NEFARIAN_MAGE_WARNING);
				DBM.Schedule(27, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5)
				DBM.EndStatusBarTimer("Class call CD");
				DBM.StartStatusBarTimer(30, "Mage call", "Interface\\Icons\\Spell_Shadow_Charm");
				DBM.AddOns.Nefarian.OnEvent("EquipBow");
			elseif arg1 == DBM_NEFARIAN_YELL_DEAD then
				DBM.UnSchedule("DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 5);
				DBM.UnSchedule("DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 0);
			end
		elseif event == "ClassCallWarning" then
			if arg1 == 5 then
				DBM.Announce(DBM_NEFARIAN_CLASS_CALL_WARNING);
				DBM.Schedule(3, "DBM.AddOns.Nefarian.OnEvent", "ClassCallWarning", 0)
			elseif arg1 == 0 then
				if UnitClass("player") == DBM_HUNTER and DBM.AddOns.Nefarian.Options.UnequipBow then
					for i = 0, 4 do
						if GetContainerNumSlots(i) then
							for j = 1, GetContainerNumSlots(i) do
								if GetContainerItemInfo(i, j) == nil then
									ClearCursor();
									PickupInventoryItem(18);
									if CursorHasItem() then
										PickupContainerItem(i, j)
										DBM.AddOns.Nefarian.BowBag = i;
										DBM.AddOns.Nefarian.BowSlot = j;
										DBM.AddOns.Nefarian.BowUnequipped = true;										
									else
										DBM.AddMsg(DBM_NEFARIAN_UNEQUIP_ERROR);
									end
									break;
								end
							end
							if DBM.AddOns.Nefarian.BowUnequipped then
								break;
							end
						end
					end
				end
			end
		elseif event == "EquipBow" then
			if DBM.AddOns.Nefarian.BowUnequipped then
				if GetContainerItemInfo(DBM.AddOns.Nefarian.BowBag, DBM.AddOns.Nefarian.BowSlot) then
					ClearCursor();
					PickupContainerItem(DBM.AddOns.Nefarian.BowBag, DBM.AddOns.Nefarian.BowSlot);
					if CursorHasItem() then
						PickupInventoryItem(18);	
						DBM.AddOns.Nefarian.BowBag = 0;
						DBM.AddOns.Nefarian.BowSlot = 0;
						DBM.AddOns.Nefarian.BowUnequipped = false;
					else
						DBM.AddMsg(DBM_NEFARIAN_EQUIP_ERROR);
					end
				else
					DBM.AddMsg(DBM_NEFARIAN_EQUIP_ERROR);
				end
			end
		end
	end,
};
