
DBM.Bosses[DBM_ONYXIAS_LAIR] = {
	["ONYXIA"] = {
		["startMethod"] = "COMBAT",
		["name"] = DBM_ONYXIA_NAME,
		["delay"] = 5,
		["BossMods"] = {
			"Onyxia",
		},
	},
};

DBM.Bosses[DBM_AZSHARA] = {
	["AZUREGOS"] = {
		["startMethod"] = "COMBAT",
		["name"] = DBM_AZUREGOS_NAME,
		["delay"] = 5,
		["BossMods"] = {
			"Azuregos",
		},
	},
};


local dragons = {
	["YSONDRE"] = {
		["startMethod"] = "COMBAT",
		["name"] = DBM_OUTDOOR_YSONDRE,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
	["EMERISS"] = {
		["startMethod"] = "COMBAT",
		["name"] = DBM_OUTDOOR_EMERISS,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
	["TAERAR"] = {
		["startMethod"] = "COMBAT",
		["name"] = DBM_OUTDOOR_TAERAR,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
	["LETHON"] = {
		["startMethod"] = "COMBAT",
		["name"] = DBM_OUTDOOR_LETHON,
		["delay"] = 5,
		["BossMods"] = {
			"OutdoorDragons",
		},
	},
}

DBM.Bosses[DBM_DUSKWOOD] = dragons
DBM.Bosses[DBM_ASHENVALE] = dragons
DBM.Bosses[DBM_FERALAS] = dragons
DBM.Bosses[DBM_HINTERLANDS] = dragons
