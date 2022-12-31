/*
indices and item IDs used here came from this:
google sheet explaining save file data by Pimez: https://docs.google.com/spreadsheets/d/1AsOEO6XCPuL29ej32D46gu-Uj5CbhDqaEGVwEBiGTBI/

Much love to Ero who helped me out a bunch on the Speedrun Tool Development discord
*/

state("PhoenotopiaAwakening") {}

startup {
    // -- Metadata --
    //Items and Upgrades
    vars.itemMeta = new Dictionary<string, Tuple<bool,string,int,int>> { // key: (default setting, type, index, ID)
        {"Slingshot", 				Tuple.Create(true,	"Tool",		0,		30)},
        {"Mysterious Golem Head", 	Tuple.Create(true,	"Status",	262,	21)},
        {"Composite Bat", 			Tuple.Create(false,	"Status",	257,	7)},
        {"Lisa's ID Card", 			Tuple.Create(false,	"Item",		0,		122)},
        {"Bandit's Flute", 			Tuple.Create(true,	"Tool",		0,		29)},
        {"Bombs", 					Tuple.Create(false,	"Tool",		0,		31)},
        {"Bart's Golem Head", 		Tuple.Create(false,	"Status",	262,	24)},
        {"Concentration", 			Tuple.Create(false,	"Status",	239,	16)},
        {"Sonic Spear", 			Tuple.Create(true,	"Tool",		0,		33)},
        {"Royal Hymn", 				Tuple.Create(false,	"Status",	252,	126)},
        {"Double Crossbow", 		Tuple.Create(false,	"Tool",		0,		38)},
        {"Spheralis Shard", 		Tuple.Create(true,	"Item",		0,		36)},
        {"Spheralis", 				Tuple.Create(true,	"Tool",		0,		35)}
    };
    vars.statusOffset = 232;
        
    // Flags
    vars.flagMeta = new Dictionary<string, Tuple<bool,int>> { // key: (default setting, index)
        {"Lockpick Flag", 			Tuple.Create(true,	27)},
        {"Games Begin", 			Tuple.Create(false,	29)},
        {"Free Fran", 				Tuple.Create(false,	186)},
        {"Wrecker", 				Tuple.Create(true,	41)},
        {"Thomas Kidnapped", 		Tuple.Create(false,	43)},
        {"Katash 1", 				Tuple.Create(true, 	507)},
        {"Tower of Dog", 			Tuple.Create(true,	553)}, // TODO: Verify which tower is which flag
        {"Tower of the King", 		Tuple.Create(true,	552)},
        {"Tower of the Queen", 		Tuple.Create(true,	551)},
        {"Megalith Station Gate", 	Tuple.Create(true,	606)},
        {"Gate to ADAM", 			Tuple.Create(true,	631)}
        // "Katash 2" handled individually
    };
    
    // Locations
    vars.roomMeta = new Dictionary<string, Tuple<bool,string>> { // key: (default setting, room)
        {"Enter Doki Forest",		Tuple.Create(false,	"p1_duri_forest_01")},
        {"Enter Atai Region", 		Tuple.Create(false,	"P1_world_map_SW")} ,
        {"Bridge Skip", 			Tuple.Create(true,	"p1_bridge_daetai_02")},
        {"Enter Daea Region", 		Tuple.Create(false,	"p1_world_map_c")},
        {"Enter Aqua Line", 		Tuple.Create(false,	"P1_daea_sewers_01")}, // yup some of these have capital P's for no discernable reason
        {"Enter Castle Dungeons", 	Tuple.Create(false,	"P1_dungeon_00")},
        {"Enter Cosette Region", 	Tuple.Create(false,	"p1_world_map_c2")},
        {"Enter Scorchlands", 		Tuple.Create(true,	"p1_scorchlands_00")},
        {"Enter Mul Caves", 		Tuple.Create(true,	"p1_mul_cave_00")},
        {"Enter SPHERE", 			Tuple.Create(false,	"p1_sphere_garden_01")},
        {"Enter E.D.E.N.", 			Tuple.Create(false,	"p1_pristine_city_hub")}
    };
    vars.visited = new List<string>();
    
    // -- Settings --
    settings.Add("Items and Upgrades", true);
    settings.Add("Miscellaneous Flags", true);
    settings.Add("Locations", true);
    
    foreach(string key in vars.itemMeta.Keys) {
        bool defaultSetting = vars.itemMeta[key].Item1;
        settings.Add(key, defaultSetting, null, "Items and Upgrades");
    }
    foreach(string key in vars.flagMeta.Keys) {
        bool defaultSetting = vars.flagMeta[key].Item1;
        settings.Add(key, defaultSetting, null, "Miscellaneous Flags");
    }
    settings.Add("Katash 2", true, null, "Miscellaneous Flags");
    foreach(string key in vars.roomMeta.Keys) {
        bool defaultSetting = vars.roomMeta[key].Item1;
        settings.Add(key, defaultSetting, null, "Locations");
    }
    
    // Items and upgrades
    settings.SetToolTip("Mysterious Golem Head", "Pick up the mysterious golem head from its crash site in the Anuri Temple");
    settings.SetToolTip("Bart's Golem Head", "Have Thomas fix Bart('s golem head)");	

    // Flags
    settings.SetToolTip("Lockpick Flag", "Find out Adar's house is locked by inspecting the door");
    settings.SetToolTip("Games Begin", "Entrust the lockpicking to Garnet and start Hide & Seek with the kids");
    settings.SetToolTip("Wrecker", "Defeat the Wrecker in Thomas' Lab");
    settings.SetToolTip("Katash 1", "Defeat Katash atop the White Towers");
    settings.SetToolTip("Gate to ADAM", "Open the final gate in EDEN with 6 chrystalis");
    settings.SetToolTip("Katash 2", "Any% timer stop");
    
    // Locations
    settings.SetToolTip("Locations", "These only trigger when you enter the location for the first time");
    settings.SetToolTip("Bridge Skip", "Enter the middle room of Kingdom Bridge for the first time");
    settings.SetToolTip("Enter SPHERE", "Specifically the building itself, not directly from the overworld");
    
    // Load asl-help
    Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
}

init {
    print("start init sleep");
    Thread.Sleep(3000);
    print("end init sleep");
    //TODO: figure out crash on game launch:
    vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
        vars.Helper["inChoiceMode"] = mono.Make<bool>("PT2", "director", "_in_CHOICE_mode");
        vars.Helper["allowInterrupt"] = mono.Make<bool>("PT2", "director", "allow_player_interrupt");
        vars.Helper["globalTimer"] = mono.Make<int>("PT2", "director", "global_timer");
        
        vars.Helper["toolInv"] = mono.MakeArray<int>("PT2", "save_file", "_tool_IDs");
        vars.Helper["itemInv"] = mono.MakeArray<int>("PT2", "save_file", "_item_IDs");
        vars.Helper["statusInv"] = mono.MakeArray<int>("PT2", "save_file", "_status_inventory"); // tuskStrike-lifeRing
        //vars.Helper["stats"] = mono.MakeArray<int>("PT2", "save_file", "_general_ints"); // playtime-critters
        vars.Helper["flags"] = mono.MakeArray<bool>("PT2", "save_file", "_booleans");
        
        vars.Helper["room"] = mono.MakeString("PT2", "_room_to_load");
        
        return true; 
    });
}

start
{
    return (current.room == "cutscene_intro") && (old.inChoiceMode && !current.inChoiceMode);
}

onStart {
    // Reset visited locations
    vars.visited.Clear();
    // Set in-game timer starting time
    vars.startTime = current.globalTimer;
}

split {
    // Items and Upgrades	
    foreach (var elem in vars.itemMeta) {
        string key = elem.Key;
        string type = elem.Value.Item2;
        int index = elem.Value.Item3 - vars.statusOffset;
        int id = elem.Value.Item4;
        /* if (!settings[key]) {
            break;
        } //performance*/
        
        bool had;
        bool has;
        switch (type) {
            case ("Status") :
                if (old.statusInv[index]!=current.statusInv[index] && current.statusInv[index]==id) {
                    print("__DEBUG__Split : " + key);
                    return settings[key];
                }
                break;
            case ("Item") :
                had = ((int[])old.itemInv).Any(x => x == id);// There defo exists a more performant way
                has = ((int[])current.itemInv).Any(x => x == id);
                if (!had && has) {
                    print("__DEBUG__Split : " + key);
                    return settings[key];
                }
                break;
            case ("Tool") :
                had = ((int[])old.toolInv).Any(x => x == id);
                has = ((int[])current.toolInv).Any(x => x == id);
                if (!had && has) {
                    print("__DEBUG__Split : " + key);
                    return settings[key];
                }
                break;
        }
    }
    // Flags
    foreach (string key in vars.flagMeta.Keys) {
        int index = vars.flagMeta[key].Item2;
        if (!old.flags[index] && current.flags[index]) {
            print("__DEBUG__Split : " + key);
            return settings[key];
        }
    }
    // Locations
    foreach (string key in vars.roomMeta.Keys) {
        string roomName = vars.roomMeta[key].Item2;
        if ((current.room==roomName) && !vars.visited.Contains(roomName)) {
            vars.visited.Add(roomName);
            print("__DEBUG__Split : " + key);
            return settings[key];
        }
    }

    // Any% Stop
    if ((current.room == "p1_phoenix_pods") && (old.allowInterrupt && !current.allowInterrupt)) {
        return settings["Katash 2"];
    }
}

gameTime
{
    return TimeSpan.FromSeconds((current.globalTimer-vars.startTime)/60.0);
}